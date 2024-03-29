#!./perl

BEGIN {
    chdir 't' if -d 't';
    @INC = '../lib';
    if ($^O eq 'MacOS') {
	push @INC, "::lib:$MacPerl::Architecture";
    }
}
# Grab all of the plain routines from File::Spec
use File::Spec @File::Spec::EXPORT_OK ;

require File::Spec::Unix ;
require File::Spec::Win32 ;

eval {
   require VMS::Filespec ;
} ;

my $skip_exception = "Install VMS::Filespec (from vms/ext)" ;

if ( $@ ) {
   # Not pretty, but it allows testing of things not implemented soley
   # on VMS.  It might be better to change File::Spec::VMS to do this,
   # making it more usable when running on (say) Unix but working with
   # VMS paths.
   eval qq-
      sub File::Spec::VMS::vmsify  { die "$skip_exception" }
      sub File::Spec::VMS::unixify { die "$skip_exception" }
      sub File::Spec::VMS::vmspath { die "$skip_exception" }
   - ;
   $INC{"VMS/Filespec.pm"} = 1 ;
}
require File::Spec::VMS ;

require File::Spec::OS2 ;
require File::Spec::Mac ;

# $root is only needed by Mac OS tests; these particular
# tests are skipped on other OSs
my $root;
if ($^O eq 'MacOS') {
	$root = File::Spec::Mac->rootdir();
}

# Each element in this array is a single test. Storing them this way makes
# maintenance easy, and should be OK since perl should be pretty functional
# before these tests are run.

@tests = (
# [ Function          ,            Expected          ,         Platform ]

[ "Unix->catfile('a','b','c')", 'a/b/c'  ],

[ "Unix->splitpath('file')",            ',,file'            ],
[ "Unix->splitpath('/d1/d2/d3/')",      ',/d1/d2/d3/,'      ],
[ "Unix->splitpath('d1/d2/d3/')",       ',d1/d2/d3/,'       ],
[ "Unix->splitpath('/d1/d2/d3/.')",     ',/d1/d2/d3/.,'     ],
[ "Unix->splitpath('/d1/d2/d3/..')",    ',/d1/d2/d3/..,'    ],
[ "Unix->splitpath('/d1/d2/d3/.file')", ',/d1/d2/d3/,.file' ],
[ "Unix->splitpath('d1/d2/d3/file')",   ',d1/d2/d3/,file'   ],
[ "Unix->splitpath('/../../d1/')",      ',/../../d1/,'      ],
[ "Unix->splitpath('/././d1/')",        ',/././d1/,'        ],

[ "Unix->catpath('','','file')",            'file'            ],
[ "Unix->catpath('','/d1/d2/d3/','')",      '/d1/d2/d3/'      ],
[ "Unix->catpath('','d1/d2/d3/','')",       'd1/d2/d3/'       ],
[ "Unix->catpath('','/d1/d2/d3/.','')",     '/d1/d2/d3/.'     ],
[ "Unix->catpath('','/d1/d2/d3/..','')",    '/d1/d2/d3/..'    ],
[ "Unix->catpath('','/d1/d2/d3/','.file')", '/d1/d2/d3/.file' ],
[ "Unix->catpath('','d1/d2/d3/','file')",   'd1/d2/d3/file'   ],
[ "Unix->catpath('','/../../d1/','')",      '/../../d1/'      ],
[ "Unix->catpath('','/././d1/','')",        '/././d1/'        ],
[ "Unix->catpath('d1','d2/d3/','')",        'd2/d3/'          ],
[ "Unix->catpath('d1','d2','d3/')",         'd2/d3/'          ],

[ "Unix->splitdir('')",           ''           ],
[ "Unix->splitdir('/d1/d2/d3/')", ',d1,d2,d3,' ],
[ "Unix->splitdir('d1/d2/d3/')",  'd1,d2,d3,'  ],
[ "Unix->splitdir('/d1/d2/d3')",  ',d1,d2,d3'  ],
[ "Unix->splitdir('d1/d2/d3')",   'd1,d2,d3'   ],

[ "Unix->catdir()",                     ''          ],
[ "Unix->catdir('/')",                  '/'         ],
[ "Unix->catdir('','d1','d2','d3','')", '/d1/d2/d3' ],
[ "Unix->catdir('d1','d2','d3','')",    'd1/d2/d3'  ],
[ "Unix->catdir('','d1','d2','d3')",    '/d1/d2/d3' ],
[ "Unix->catdir('d1','d2','d3')",       'd1/d2/d3'  ],

[ "Unix->catfile('a','b','c')", 'a/b/c' ],

[ "Unix->canonpath('')",                                      ''          ],
[ "Unix->canonpath('///../../..//./././a//b/.././c/././')",   '/a/b/../c' ],
[ "Unix->canonpath('/.')",                                    '/'         ],
[ "Unix->canonpath('/./')",                                   '/'         ],
[ "Unix->canonpath('/a/./')",                                 '/a'        ],
[ "Unix->canonpath('/a/.')",                                  '/a'        ],

[  "Unix->abs2rel('/t1/t2/t3','/t1/t2/t3')",          ''                   ],
[  "Unix->abs2rel('/t1/t2/t4','/t1/t2/t3')",          '../t4'              ],
[  "Unix->abs2rel('/t1/t2','/t1/t2/t3')",             '..'                 ],
[  "Unix->abs2rel('/t1/t2/t3/t4','/t1/t2/t3')",       't4'                 ],
[  "Unix->abs2rel('/t4/t5/t6','/t1/t2/t3')",          '../../../t4/t5/t6'  ],
#[ "Unix->abs2rel('../t4','/t1/t2/t3')",              '../t4'              ],
[  "Unix->abs2rel('/','/t1/t2/t3')",                  '../../..'           ],
[  "Unix->abs2rel('///','/t1/t2/t3')",                '../../..'           ],
[  "Unix->abs2rel('/.','/t1/t2/t3')",                 '../../..'           ],
[  "Unix->abs2rel('/./','/t1/t2/t3')",                '../../..'           ],
#[ "Unix->abs2rel('../t4','/t1/t2/t3')",              '../t4'              ],

[ "Unix->rel2abs('t4','/t1/t2/t3')",             '/t1/t2/t3/t4'    ],
[ "Unix->rel2abs('t4/t5','/t1/t2/t3')",          '/t1/t2/t3/t4/t5' ],
[ "Unix->rel2abs('.','/t1/t2/t3')",              '/t1/t2/t3'       ],
[ "Unix->rel2abs('..','/t1/t2/t3')",             '/t1/t2/t3/..'    ],
[ "Unix->rel2abs('../t4','/t1/t2/t3')",          '/t1/t2/t3/../t4' ],
[ "Unix->rel2abs('/t1','/t1/t2/t3')",            '/t1'             ],

[ "Win32->splitpath('file')",                            ',,file'                            ],
[ "Win32->splitpath('\\d1/d2\\d3/')",                    ',\\d1/d2\\d3/,'                    ],
[ "Win32->splitpath('d1/d2\\d3/')",                      ',d1/d2\\d3/,'                      ],
[ "Win32->splitpath('\\d1/d2\\d3/.')",                   ',\\d1/d2\\d3/.,'                   ],
[ "Win32->splitpath('\\d1/d2\\d3/..')",                  ',\\d1/d2\\d3/..,'                  ],
[ "Win32->splitpath('\\d1/d2\\d3/.file')",               ',\\d1/d2\\d3/,.file'               ],
[ "Win32->splitpath('\\d1/d2\\d3/file')",                ',\\d1/d2\\d3/,file'                ],
[ "Win32->splitpath('d1/d2\\d3/file')",                  ',d1/d2\\d3/,file'                  ],
[ "Win32->splitpath('C:\\d1/d2\\d3/')",                  'C:,\\d1/d2\\d3/,'                  ],
[ "Win32->splitpath('C:d1/d2\\d3/')",                    'C:,d1/d2\\d3/,'                    ],
[ "Win32->splitpath('C:\\d1/d2\\d3/file')",              'C:,\\d1/d2\\d3/,file'              ],
[ "Win32->splitpath('C:d1/d2\\d3/file')",                'C:,d1/d2\\d3/,file'                ],
[ "Win32->splitpath('C:\\../d2\\d3/file')",              'C:,\\../d2\\d3/,file'              ],
[ "Win32->splitpath('C:../d2\\d3/file')",                'C:,../d2\\d3/,file'                ],
[ "Win32->splitpath('\\../..\\d1/')",                    ',\\../..\\d1/,'                    ],
[ "Win32->splitpath('\\./.\\d1/')",                      ',\\./.\\d1/,'                      ],
[ "Win32->splitpath('\\\\node\\share\\d1/d2\\d3/')",     '\\\\node\\share,\\d1/d2\\d3/,'     ],
[ "Win32->splitpath('\\\\node\\share\\d1/d2\\d3/file')", '\\\\node\\share,\\d1/d2\\d3/,file' ],
[ "Win32->splitpath('\\\\node\\share\\d1/d2\\file')",    '\\\\node\\share,\\d1/d2\\,file'    ],
[ "Win32->splitpath('file',1)",                          ',file,'                            ],
[ "Win32->splitpath('\\d1/d2\\d3/',1)",                  ',\\d1/d2\\d3/,'                    ],
[ "Win32->splitpath('d1/d2\\d3/',1)",                    ',d1/d2\\d3/,'                      ],
[ "Win32->splitpath('\\\\node\\share\\d1/d2\\d3/',1)",   '\\\\node\\share,\\d1/d2\\d3/,'     ],

[ "Win32->catpath('','','file')",                            'file'                            ],
[ "Win32->catpath('','\\d1/d2\\d3/','')",                    '\\d1/d2\\d3/'                    ],
[ "Win32->catpath('','d1/d2\\d3/','')",                      'd1/d2\\d3/'                      ],
[ "Win32->catpath('','\\d1/d2\\d3/.','')",                   '\\d1/d2\\d3/.'                   ],
[ "Win32->catpath('','\\d1/d2\\d3/..','')",                  '\\d1/d2\\d3/..'                  ],
[ "Win32->catpath('','\\d1/d2\\d3/','.file')",               '\\d1/d2\\d3/.file'               ],
[ "Win32->catpath('','\\d1/d2\\d3/','file')",                '\\d1/d2\\d3/file'                ],
[ "Win32->catpath('','d1/d2\\d3/','file')",                  'd1/d2\\d3/file'                  ],
[ "Win32->catpath('C:','\\d1/d2\\d3/','')",                  'C:\\d1/d2\\d3/'                  ],
[ "Win32->catpath('C:','d1/d2\\d3/','')",                    'C:d1/d2\\d3/'                    ],
[ "Win32->catpath('C:','\\d1/d2\\d3/','file')",              'C:\\d1/d2\\d3/file'              ],
[ "Win32->catpath('C:','d1/d2\\d3/','file')",                'C:d1/d2\\d3/file'                ],
[ "Win32->catpath('C:','\\../d2\\d3/','file')",              'C:\\../d2\\d3/file'              ],
[ "Win32->catpath('C:','../d2\\d3/','file')",                'C:../d2\\d3/file'                ],
[ "Win32->catpath('','\\../..\\d1/','')",                    '\\../..\\d1/'                    ],
[ "Win32->catpath('','\\./.\\d1/','')",                      '\\./.\\d1/'                      ],
[ "Win32->catpath('\\\\node\\share','\\d1/d2\\d3/','')",     '\\\\node\\share\\d1/d2\\d3/'     ],
[ "Win32->catpath('\\\\node\\share','\\d1/d2\\d3/','file')", '\\\\node\\share\\d1/d2\\d3/file' ],
[ "Win32->catpath('\\\\node\\share','\\d1/d2\\','file')",    '\\\\node\\share\\d1/d2\\file'    ],

[ "Win32->splitdir('')",             ''           ],
[ "Win32->splitdir('\\d1/d2\\d3/')", ',d1,d2,d3,' ],
[ "Win32->splitdir('d1/d2\\d3/')",   'd1,d2,d3,'  ],
[ "Win32->splitdir('\\d1/d2\\d3')",  ',d1,d2,d3'  ],
[ "Win32->splitdir('d1/d2\\d3')",    'd1,d2,d3'   ],

[ "Win32->catdir()",                        ''                   ],
[ "Win32->catdir('')",                      '\\'                 ],
[ "Win32->catdir('/')",                     '\\'                 ],
[ "Win32->catdir('//d1','d2')",             '\\\\d1\\d2'         ],
[ "Win32->catdir('','/d1','d2')",           '\\\\d1\\d2'         ],
[ "Win32->catdir('','','/d1','d2')",        '\\\\\\d1\\d2'       ],
[ "Win32->catdir('','//d1','d2')",          '\\\\\\d1\\d2'       ],
[ "Win32->catdir('','','//d1','d2')",       '\\\\\\\\d1\\d2'     ],
[ "Win32->catdir('','d1','','d2','')",      '\\d1\\d2'           ],
[ "Win32->catdir('','d1','d2','d3','')",    '\\d1\\d2\\d3'       ],
[ "Win32->catdir('d1','d2','d3','')",       'd1\\d2\\d3'         ],
[ "Win32->catdir('','d1','d2','d3')",       '\\d1\\d2\\d3'       ],
[ "Win32->catdir('d1','d2','d3')",          'd1\\d2\\d3'         ],
[ "Win32->catdir('A:/d1','d2','d3')",       'A:\\d1\\d2\\d3'     ],
[ "Win32->catdir('A:/d1','d2','d3','')",    'A:\\d1\\d2\\d3'     ],
#[ "Win32->catdir('A:/d1','B:/d2','d3','')", 'A:\\d1\\d2\\d3'     ],
[ "Win32->catdir('A:/d1','B:/d2','d3','')", 'A:\\d1\\B:\\d2\\d3' ],
[ "Win32->catdir('A:/')",                   'A:\\'               ],

[ "Win32->catfile('a','b','c')", 'a\\b\\c' ],

[ "Win32->canonpath('')",               ''                    ],
[ "Win32->canonpath('a:')",             'A:'                  ],
[ "Win32->canonpath('A:f')",            'A:f'                 ],
[ "Win32->canonpath('//a\\b//c')",      '\\\\a\\b\\c'         ],
[ "Win32->canonpath('/a/..../c')",      '\\a\\....\\c'        ],
[ "Win32->canonpath('//a/b\\c')",       '\\\\a\\b\\c'         ],
[ "Win32->canonpath('////')",           '\\\\\\'              ],
[ "Win32->canonpath('//')",             '\\'                  ],
[ "Win32->canonpath('/.')",             '\\.'                 ],
[ "Win32->canonpath('//a/b/../../c')",  '\\\\a\\b\\..\\..\\c' ],
[ "Win32->canonpath('//a/../../c')",    '\\\\a\\..\\..\\c'    ],

[  "Win32->abs2rel('/t1/t2/t3','/t1/t2/t3')",    ''                       ],
[  "Win32->abs2rel('/t1/t2/t4','/t1/t2/t3')",    '..\\t4'                 ],
[  "Win32->abs2rel('/t1/t2','/t1/t2/t3')",       '..'                     ],
[  "Win32->abs2rel('/t1/t2/t3/t4','/t1/t2/t3')", 't4'                     ],
[  "Win32->abs2rel('/t4/t5/t6','/t1/t2/t3')",    '..\\..\\..\\t4\\t5\\t6' ],
#[ "Win32->abs2rel('../t4','/t1/t2/t3')",        '\\t1\\t2\\t3\\..\\t4'   ],
[  "Win32->abs2rel('/','/t1/t2/t3')",            '..\\..\\..'             ],
[  "Win32->abs2rel('///','/t1/t2/t3')",          '..\\..\\..'             ],
[  "Win32->abs2rel('/.','/t1/t2/t3')",           '..\\..\\..\\.'          ],
[  "Win32->abs2rel('/./','/t1/t2/t3')",          '..\\..\\..'             ],
[  "Win32->abs2rel('\\\\a/t1/t2/t4','/t2/t3')",  '..\\t4'                 ],
[  "Win32->abs2rel('//a/t1/t2/t4','/t2/t3')",    '..\\t4'                 ],

[ "Win32->rel2abs('temp','C:/')",                       'C:\\temp'                        ],
[ "Win32->rel2abs('temp','C:/a')",                      'C:\\a\\temp'                     ],
[ "Win32->rel2abs('temp','C:/a/')",                     'C:\\a\\temp'                     ],
[ "Win32->rel2abs('../','C:/')",                        'C:\\..'                          ],
[ "Win32->rel2abs('../','C:/a')",                       'C:\\a\\..'                       ],
[ "Win32->rel2abs('temp','//prague_main/work/')",       '\\\\prague_main\\work\\temp'     ],
[ "Win32->rel2abs('../temp','//prague_main/work/')",    '\\\\prague_main\\work\\..\\temp' ],
[ "Win32->rel2abs('temp','//prague_main/work')",        '\\\\prague_main\\work\\temp'     ],
[ "Win32->rel2abs('../','//prague_main/work')",         '\\\\prague_main\\work\\..'       ],

[ "VMS->splitpath('file')",                                       ',,file'                                   ],
[ "VMS->splitpath('[d1.d2.d3]')",                                 ',[d1.d2.d3],'                               ],
[ "VMS->splitpath('[.d1.d2.d3]')",                                ',[.d1.d2.d3],'                              ],
[ "VMS->splitpath('[d1.d2.d3]file')",                             ',[d1.d2.d3],file'                           ],
[ "VMS->splitpath('d1/d2/d3/file')",                              ',[.d1.d2.d3],file'                          ],
[ "VMS->splitpath('/d1/d2/d3/file')",                             'd1:,[d2.d3],file'                         ],
[ "VMS->splitpath('[.d1.d2.d3]file')",                            ',[.d1.d2.d3],file'                          ],
[ "VMS->splitpath('node::volume:[d1.d2.d3]')",                    'node::volume:,[d1.d2.d3],'                  ],
[ "VMS->splitpath('node::volume:[d1.d2.d3]file')",                'node::volume:,[d1.d2.d3],file'              ],
[ "VMS->splitpath('node\"access_spec\"::volume:[d1.d2.d3]')",     'node"access_spec"::volume:,[d1.d2.d3],'     ],
[ "VMS->splitpath('node\"access_spec\"::volume:[d1.d2.d3]file')", 'node"access_spec"::volume:,[d1.d2.d3],file' ],

[ "VMS->catpath('','','file')",                                       'file'                                     ],
[ "VMS->catpath('','[d1.d2.d3]','')",                                 '[d1.d2.d3]'                               ],
[ "VMS->catpath('','[.d1.d2.d3]','')",                                '[.d1.d2.d3]'                              ],
[ "VMS->catpath('','[d1.d2.d3]','file')",                             '[d1.d2.d3]file'                           ],
[ "VMS->catpath('','[.d1.d2.d3]','file')",                            '[.d1.d2.d3]file'                          ],
[ "VMS->catpath('','d1/d2/d3','file')",                               '[.d1.d2.d3]file'                            ],
[ "VMS->catpath('v','d1/d2/d3','file')",                              'v:[.d1.d2.d3]file'                            ],
[ "VMS->catpath('node::volume:','[d1.d2.d3]','')",                    'node::volume:[d1.d2.d3]'                  ],
[ "VMS->catpath('node::volume:','[d1.d2.d3]','file')",                'node::volume:[d1.d2.d3]file'              ],
[ "VMS->catpath('node\"access_spec\"::volume:','[d1.d2.d3]','')",     'node"access_spec"::volume:[d1.d2.d3]'     ],
[ "VMS->catpath('node\"access_spec\"::volume:','[d1.d2.d3]','file')", 'node"access_spec"::volume:[d1.d2.d3]file' ],

[ "VMS->canonpath('')",                                    ''                        ],
[ "VMS->canonpath('volume:[d1]file')",                     'volume:[d1]file'         ],
[ "VMS->canonpath('volume:[d1.-.d2.][d3.d4.-]')",              'volume:[d2.d3]'          ],
[ "VMS->canonpath('volume:[000000.d1]d2.dir;1')",                 'volume:[d1]d2.dir;1'   ],

[ "VMS->splitdir('')",            ''          ],
[ "VMS->splitdir('[]')",          ''          ],
[ "VMS->splitdir('d1.d2.d3')",    'd1,d2,d3'  ],
[ "VMS->splitdir('[d1.d2.d3]')",  'd1,d2,d3'  ],
[ "VMS->splitdir('.d1.d2.d3')",   ',d1,d2,d3' ],
[ "VMS->splitdir('[.d1.d2.d3]')", ',d1,d2,d3' ],
[ "VMS->splitdir('.-.d2.d3')",    ',-,d2,d3'  ],
[ "VMS->splitdir('[.-.d2.d3]')",  ',-,d2,d3'  ],

[ "VMS->catdir('')",                                                      ''                 ],
[ "VMS->catdir('d1','d2','d3')",                                          '[.d1.d2.d3]'         ],
[ "VMS->catdir('d1','d2/','d3')",                                         '[.d1.d2.d3]'         ],
[ "VMS->catdir('','d1','d2','d3')",                                       '[.d1.d2.d3]'        ],
[ "VMS->catdir('','-','d2','d3')",                                        '[-.d2.d3]'         ],
[ "VMS->catdir('','-','','d3')",                                          '[-.d3]'            ],
[ "VMS->catdir('dir.dir','d2.dir','d3.dir')",                             '[.dir.d2.d3]'        ],
[ "VMS->catdir('[.name]')",                                               '[.name]'            ],
[ "VMS->catdir('[.name]','[.name]')",                                     '[.name.name]'],

[  "VMS->abs2rel('node::volume:[t1.t2.t3]','[t1.t2.t3]')", ''                 ],
[  "VMS->abs2rel('node::volume:[t1.t2.t4]','[t1.t2.t3]')", '[-.t4]'           ],
[  "VMS->abs2rel('[t1.t2.t3]','[t1.t2.t3]')",              ''                 ],
[  "VMS->abs2rel('[t1.t2.t3]file','[t1.t2.t3]')",          'file'             ],
[  "VMS->abs2rel('[t1.t2.t4]','[t1.t2.t3]')",              '[-.t4]'           ],
[  "VMS->abs2rel('[t1.t2]file','[t1.t2.t3]')",             '[-]file'          ],
[  "VMS->abs2rel('[t1.t2.t3.t4]','[t1.t2.t3]')",           '[t4]'             ],
[  "VMS->abs2rel('[t4.t5.t6]','[t1.t2.t3]')",              '[---.t4.t5.t6]'   ],
[ "VMS->abs2rel('[000000]','[t1.t2.t3]')",                 '[---]'            ],
[ "VMS->abs2rel('a:[t1.t2.t4]','[t1.t2.t3]')",             '[-.t4]'           ],
[ "VMS->abs2rel('[a.-.b.c.-]','[t1.t2.t3]')",              '[---.b]'          ],

[ "VMS->rel2abs('[.t4]','[t1.t2.t3]')",          '[t1.t2.t3.t4]'    ],
[ "VMS->rel2abs('[.t4.t5]','[t1.t2.t3]')",       '[t1.t2.t3.t4.t5]' ],
[ "VMS->rel2abs('[]','[t1.t2.t3]')",             '[t1.t2.t3]'       ],
[ "VMS->rel2abs('[-]','[t1.t2.t3]')",            '[t1.t2]'          ],
[ "VMS->rel2abs('[-.t4]','[t1.t2.t3]')",         '[t1.t2.t4]'       ],
[ "VMS->rel2abs('[t1]','[t1.t2.t3]')",           '[t1]'             ],

[ "OS2->catdir('A:/d1','B:/d2','d3','')", 'A:/d1/B:/d2/d3' ],
[ "OS2->catfile('a','b','c')",            'a/b/c'          ],


[ "Mac->catpath('','','')",              ''                ],
[ "Mac->catpath('',':','')",             ':'               ],
[ "Mac->catpath('','::','')",            '::'              ],

[ "Mac->catpath('hd','','')",            'hd:'             ],
[ "Mac->catpath('hd:','','')",           'hd:'             ],
[ "Mac->catpath('hd:',':','')",          'hd:'             ],
[ "Mac->catpath('hd:','::','')",         'hd::'            ],

[ "Mac->catpath('hd','','file')",       'hd:file'          ],
[ "Mac->catpath('hd',':','file')",      'hd:file'          ],
[ "Mac->catpath('hd','::','file')",     'hd::file'         ],
[ "Mac->catpath('hd',':::','file')",    'hd:::file'        ],

[ "Mac->catpath('hd:','',':file')",      'hd:file'         ],
[ "Mac->catpath('hd:',':',':file')",     'hd:file'         ],
[ "Mac->catpath('hd:','::',':file')",    'hd::file'        ],
[ "Mac->catpath('hd:',':::',':file')",   'hd:::file'       ],

[ "Mac->catpath('hd:','d1','file')",     'hd:d1:file'      ],
[ "Mac->catpath('hd:',':d1:',':file')",  'hd:d1:file'      ],

[ "Mac->catpath('','d1','')",            ':d1:'            ],
[ "Mac->catpath('',':d1','')",           ':d1:'            ],
[ "Mac->catpath('',':d1:','')",          ':d1:'            ],

[ "Mac->catpath('','d1','file')",        ':d1:file'        ],
[ "Mac->catpath('',':d1:',':file')",     ':d1:file'        ],

[ "Mac->catpath('','','file')",          'file'            ],
[ "Mac->catpath('','',':file')",         'file'            ], # !
[ "Mac->catpath('',':',':file')",        ':file'           ], # !


[ "Mac->splitpath(':')",              ',:,'               ],
[ "Mac->splitpath('::')",             ',::,'              ],
[ "Mac->splitpath(':::')",            ',:::,'             ],

[ "Mac->splitpath('file')",           ',,file'            ],
[ "Mac->splitpath(':file')",          ',:,file'           ],

[ "Mac->splitpath('d1',1)",           ',:d1:,'            ], # dir, not volume
[ "Mac->splitpath(':d1',1)",          ',:d1:,'            ],
[ "Mac->splitpath(':d1:',1)",         ',:d1:,'            ],
[ "Mac->splitpath(':d1:')",           ',:d1:,'            ],
[ "Mac->splitpath(':d1:d2:d3:')",     ',:d1:d2:d3:,'      ],
[ "Mac->splitpath(':d1:d2:d3:',1)",   ',:d1:d2:d3:,'      ],
[ "Mac->splitpath(':d1:file')",       ',:d1:,file'        ],
[ "Mac->splitpath('::d1:file')",      ',::d1:,file'       ],

[ "Mac->splitpath('hd:', 1)",         'hd:,,'             ],
[ "Mac->splitpath('hd:')",            'hd:,,'             ],
[ "Mac->splitpath('hd:d1:d2:')",      'hd:,:d1:d2:,'      ],
[ "Mac->splitpath('hd:d1:d2',1)",     'hd:,:d1:d2:,'      ],
[ "Mac->splitpath('hd:d1:d2:file')",  'hd:,:d1:d2:,file'  ],
[ "Mac->splitpath('hd:d1:d2::file')", 'hd:,:d1:d2::,file' ],
[ "Mac->splitpath('hd::d1:d2:file')", 'hd:,::d1:d2:,file' ], # invalid path
[ "Mac->splitpath('hd:file')",        'hd:,,file'         ],

[ "Mac->splitdir()",                   ''            ],
[ "Mac->splitdir('')",                 ''            ],
[ "Mac->splitdir(':')",                ':'           ],
[ "Mac->splitdir('::')",               '::'          ],
[ "Mac->splitdir(':::')",              '::,::'       ],
[ "Mac->splitdir(':::d1:d2')",         '::,::,d1,d2' ],

[ "Mac->splitdir(':d1:d2:d3::')",      'd1,d2,d3,::'],
[ "Mac->splitdir(':d1:d2:d3:')",       'd1,d2,d3'   ],
[ "Mac->splitdir(':d1:d2:d3')",        'd1,d2,d3'   ],

# absolute paths in splitdir() work, but you'd better use splitpath()
[ "Mac->splitdir('hd:')",              'hd:'              ],
[ "Mac->splitdir('hd::')",             'hd:,::'           ], # invalid path, but it works
[ "Mac->splitdir('hd::d1:')",          'hd:,::,d1'        ], # invalid path, but it works
[ "Mac->splitdir('hd:d1:d2:::')",      'hd:,d1,d2,::,::'  ],
[ "Mac->splitdir('hd:d1:d2::')",       'hd:,d1,d2,::'     ],
[ "Mac->splitdir('hd:d1:d2:')",        'hd:,d1,d2'        ],
[ "Mac->splitdir('hd:d1:d2')",         'hd:,d1,d2'        ],
[ "Mac->splitdir('hd:d1::d2::')",      'hd:,d1,::,d2,::'  ],

[ "Mac->catdir()",                 ''             ],
[ "Mac->catdir('')",               $root, 'MacOS' ], # skipped on other OS
[ "Mac->catdir(':')",              ':'            ],

[ "Mac->catdir('', '')",           $root, 'MacOS' ], # skipped on other OS
[ "Mac->catdir('', ':')",          $root, 'MacOS' ], # skipped on other OS
[ "Mac->catdir(':', ':')",         ':'            ],
[ "Mac->catdir(':', '')",          ':'            ],

[ "Mac->catdir('', '::')",         $root, 'MacOS' ], # skipped on other OS
[ "Mac->catdir(':', '::')",        '::'           ],

[ "Mac->catdir('::', '')",         '::'           ],
[ "Mac->catdir('::', ':')",        '::'           ],

[ "Mac->catdir('::', '::')",       ':::'          ],

[ "Mac->catdir(':d1')",                    ':d1:'        ],
[ "Mac->catdir(':d1:')",                   ':d1:'        ],
[ "Mac->catdir(':d1','d2')",               ':d1:d2:'     ],
[ "Mac->catdir(':d1',':d2')",              ':d1:d2:'     ],
[ "Mac->catdir(':d1',':d2:')",             ':d1:d2:'     ],
[ "Mac->catdir(':d1',':d2::')",            ':d1:d2::'     ],
[ "Mac->catdir(':',':d1',':d2')",          ':d1:d2:'     ],
[ "Mac->catdir('::',':d1',':d2')",         '::d1:d2:'    ],
[ "Mac->catdir('::','::',':d1',':d2')",    ':::d1:d2:'   ],
[ "Mac->catdir(':',':',':d1',':d2')",      ':d1:d2:'     ],
[ "Mac->catdir('::',':',':d1',':d2')",     '::d1:d2:'    ],

[ "Mac->catdir('d1')",                    ':d1:'         ],
[ "Mac->catdir('d1','d2','d3')",          ':d1:d2:d3:'   ],
[ "Mac->catdir('d1','d2/','d3')",         ':d1:d2/:d3:'  ],
[ "Mac->catdir('d1','',':d2')",           ':d1:d2:'      ],
[ "Mac->catdir('d1',':',':d2')",          ':d1:d2:'      ],
[ "Mac->catdir('d1','::',':d2')",         ':d1::d2:'     ],
[ "Mac->catdir('d1',':::',':d2')",        ':d1:::d2:'    ],
[ "Mac->catdir('d1','::','::',':d2')",    ':d1:::d2:'    ],
[ "Mac->catdir('d1','d2')",               ':d1:d2:'      ],
[ "Mac->catdir('d1','d2', '')",           ':d1:d2:'      ],
[ "Mac->catdir('d1','d2', ':')",          ':d1:d2:'      ],
[ "Mac->catdir('d1','d2', '::')",         ':d1:d2::'     ],
[ "Mac->catdir('d1','d2','','')",         ':d1:d2:'      ],
[ "Mac->catdir('d1','d2',':','::')",      ':d1:d2::'     ],
[ "Mac->catdir('d1','d2','::','::')",     ':d1:d2:::'    ],
[ "Mac->catdir('d1',':d2')",              ':d1:d2:'      ],
[ "Mac->catdir('d1',':d2:')",             ':d1:d2:'      ],

[ "Mac->catdir('','d1','d2','d3')",        $root . 'd1:d2:d3:', 'MacOS' ], # skipped on other OS
[ "Mac->catdir('',':','d1','d2')",         $root . 'd1:d2:'   , 'MacOS' ], # skipped on other OS
[ "Mac->catdir('','::','d1','d2')",        $root . 'd1:d2:'   , 'MacOS' ], # skipped on other OS
[ "Mac->catdir('',':','','d1')",           $root . 'd1:'      , 'MacOS' ], # skipped on other OS
[ "Mac->catdir('', ':d1',':d2')",          $root . 'd1:d2:'   , 'MacOS' ], # skipped on other OS
[ "Mac->catdir('','',':d1',':d2')",        $root . 'd1:d2:'   , 'MacOS' ], # skipped on other OS

[ "Mac->catdir('hd:',':d1')",       'hd:d1:'      ],
[ "Mac->catdir('hd:d1:',':d2')",    'hd:d1:d2:'   ],
[ "Mac->catdir('hd:','d1')",        'hd:d1:'      ],
[ "Mac->catdir('hd:d1:',':d2')",    'hd:d1:d2:'   ],
[ "Mac->catdir('hd:d1:',':d2:')",   'hd:d1:d2:'   ],

[ "Mac->catfile()",                      ''                      ],
[ "Mac->catfile('')",                    ''                      ],
[ "Mac->catfile('', '')",                $root         , 'MacOS' ], # skipped on other OS
[ "Mac->catfile('', 'file')",            $root . 'file', 'MacOS' ], # skipped on other OS
[ "Mac->catfile(':')",                   ':'                     ],
[ "Mac->catfile(':', '')",               ':'                     ],

[ "Mac->catfile('d1','d2','file')",      ':d1:d2:file' ],
[ "Mac->catfile('d1','d2',':file')",     ':d1:d2:file' ],
[ "Mac->catfile('file')",                'file'        ],
[ "Mac->catfile(':', 'file')",           ':file'       ],

[ "Mac->canonpath('')",                   ''     ],
[ "Mac->canonpath(':')",                  ':'    ],
[ "Mac->canonpath('::')",                 '::'   ],
[ "Mac->canonpath('a::')",                'a::'  ],
[ "Mac->canonpath(':a::')",               ':a::' ],

[ "Mac->abs2rel('hd:d1:d2:','hd:d1:d2:')",            ':'            ],
[ "Mac->abs2rel('hd:d1:d2:','hd:d1:d2:file')",        ':'            ], # ignore base's file portion
[ "Mac->abs2rel('hd:d1:d2:file','hd:d1:d2:')",        ':file'        ],
[ "Mac->abs2rel('hd:d1:','hd:d1:d2:')",               '::'           ],
[ "Mac->abs2rel('hd:d3:','hd:d1:d2:')",               ':::d3:'       ],
[ "Mac->abs2rel('hd:d3:','hd:d1:d2::')",              '::d3:'        ],
[ "Mac->abs2rel('hd:d1:d4:d5:','hd:d1::d2:d3::')",    '::d1:d4:d5:'  ],
[ "Mac->abs2rel('hd:d1:d4:d5:','hd:d1::d2:d3:')",     ':::d1:d4:d5:' ], # first, resolve updirs in base
[ "Mac->abs2rel('hd:d1:d3:','hd:d1:d2:')",            '::d3:'        ],
[ "Mac->abs2rel('hd:d1::d3:','hd:d1:d2:')",           ':::d3:'       ],
[ "Mac->abs2rel('hd:d3:','hd:d1:d2:')",               ':::d3:'       ], # same as above
[ "Mac->abs2rel('hd:d1:d2:d3:','hd:d1:d2:')",         ':d3:'         ],
[ "Mac->abs2rel('hd:d1:d2:d3::','hd:d1:d2:')",        ':d3::'        ],
[ "Mac->abs2rel('hd1:d3:d4:d5:','hd2:d1:d2:')",       ':::d3:d4:d5:' ], # ignore base's volume
[ "Mac->abs2rel('hd:','hd:d1:d2:')",                  ':::'          ],

[ "Mac->rel2abs(':d3:','hd:d1:d2:')",          'hd:d1:d2:d3:'     ],
[ "Mac->rel2abs(':d3:d4:','hd:d1:d2:')",       'hd:d1:d2:d3:d4:'  ],
[ "Mac->rel2abs('','hd:d1:d2:')",              ''                 ],
[ "Mac->rel2abs('::','hd:d1:d2:')",            'hd:d1:d2::'       ],
[ "Mac->rel2abs('::','hd:d1:d2:file')",        'hd:d1:d2::'       ],# ignore base's file portion
[ "Mac->rel2abs(':file','hd:d1:d2:')",         'hd:d1:d2:file'    ],
[ "Mac->rel2abs('::file','hd:d1:d2:')",        'hd:d1:d2::file'   ],
[ "Mac->rel2abs('::d3:','hd:d1:d2:')",         'hd:d1:d2::d3:'    ],
[ "Mac->rel2abs('hd:','hd:d1:d2:')",           'hd:'              ], # path already absolute
[ "Mac->rel2abs('hd:d3:file','hd:d1:d2:')",    'hd:d3:file'       ],
[ "Mac->rel2abs('hd:d3:','hd:d1:file')",       'hd:d3:'           ],
) ;


print "1..", scalar( @tests ), "\n" ;

my $current_test= 1 ;

# Test out the class methods
for ( @tests ) {
   tryfunc( @$_ ) ;
}


#
# Tries a named function with the given args and compares the result against
# an expected result. Works with functions that return scalars or arrays.
#
sub tryfunc {
    my $function = shift ;
    my $expected = shift ;
    my $platform = shift ;

    if ($platform && $^O ne $platform) {
	print "ok $current_test # skipped: $function\n" ;
	++$current_test ;
	return;
    }

    $function =~ s#\\#\\\\#g ;

    my $got ;
    if ( $function =~ /^[^\$].*->/ ) {
	$got = eval( "join( ',', File::Spec::$function )" ) ;
    }
    else {
	$got = eval( "join( ',', $function )" ) ;
    }

    if ( $@ ) {
        if ( substr( $@, 0, length $skip_exception ) eq $skip_exception ) {
	    chomp $@ ;
	    print "ok $current_test # skip $function: $@\n" ;
	}
	else {
	    chomp $@ ;
	    print "not ok $current_test # $function: $@\n" ;
	}
    }
    elsif ( !defined( $got ) || $got ne $expected ) {
	print "not ok $current_test # $function: got '$got', expected '$expected'\n" ;
    }
    else {
	print "ok $current_test # $function\n" ;
    }
    ++$current_test ;
}
