/* $Header$
 *
 *    Copyright (c) 1996 Matthias Neeracher
 *
 *    You may distribute under the terms of the Perl Artistic License,
 *    as specified in the README file.
 *
 * $Log$
 * Revision 1.2  1997/11/18 00:52:26  neeri
 * MacPerl 5.1.5
 *
 * Revision 1.1  1997/04/07 20:49:45  neeri
 * Synchronized with MacPerl 5.1.4a1
 *
 */

#define MAC_CONTEXT

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include <Gestalt.h>

MODULE = Mac::Gestalt	PACKAGE = Mac::Gestalt

=head2 Functions

=over 4

=item Gestalt SELECTOR

Implements the Gestalt query code.
Return C<undef> if an error was detected.

=cut
long
Gestalt(selector)
	OSType selector
	CODE:
	if (gLastMacOSErr = Gestalt(selector, &RETVAL)) {
		XSRETURN_UNDEF;
	}
	OUTPUT:
	RETVAL

=back

=cut
