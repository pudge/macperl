/* dl_win32.xs
 * 
 * Platform:	Win32 (Windows NT/Windows 95)
 * Author:	Wei-Yuen Tan (wyt@hip.com)
 * Created:	A warm day in June, 1995
 *
 * Modified:
 *    August 23rd 1995 - rewritten after losing everything when I
 *                       wiped off my NT partition (eek!)
 */

/* Porting notes:

I merely took Paul's dl_dlopen.xs, took out extraneous stuff and
replaced the appropriate SunOS calls with the corresponding Win32
calls.

*/

#define WIN32_LEAN_AND_MEAN
#ifdef __GNUC__
#define Win32_Winsock
#endif
#include <windows.h>
#include <string.h>

#define PERL_NO_GET_CONTEXT

#include "EXTERN.h"
#include "perl.h"
#include "win32.h"

#ifdef PERL_OBJECT
#define NO_XSLOCKS
#endif  /* PERL_OBJECT */

#include "XSUB.h"

typedef struct {
    SV *	x_error_sv;
} my_cxtx_t;		/* this *must* be named my_cxtx_t */

#define DL_CXT_EXTRA	/* ask for dl_cxtx to be defined in dlutils.c */
#include "dlutils.c"	/* SaveError() etc	*/

#define dl_error_sv	(dl_cxtx.x_error_sv)

static char *
OS_Error_String(pTHXo)
{
    dMY_CXT;
    DWORD err = GetLastError();
    STRLEN len;
    if (!dl_error_sv)
	dl_error_sv = newSVpvn("",0);
    PerlProc_GetOSError(dl_error_sv,err);
    return SvPV(dl_error_sv,len);
}

static void
dl_private_init(pTHXo)
{
    (void)dl_generic_private_init(aTHXo);
}

/* 
    This function assumes the list staticlinkmodules
    will be formed from package names with '::' replaced
    with '/'. Thus Win32::OLE is in the list as Win32/OLE
*/
static int
dl_static_linked(char *filename)
{
    char **p;
    char* ptr;
    static char subStr[] = "/auto/";
    char szBuffer[MAX_PATH];

    /* change all the '\\' to '/' */
    strcpy(szBuffer, filename);
    for(ptr = szBuffer; ptr = strchr(ptr, '\\'); ++ptr)
	*ptr = '/';

    /* delete the file name */
    ptr = strrchr(szBuffer, '/');
    if(ptr != NULL)
	*ptr = '\0';

    /* remove leading lib path */
    ptr = strstr(szBuffer, subStr);
    if(ptr != NULL)
	ptr += sizeof(subStr)-1;
    else
	ptr = szBuffer;

    for (p = staticlinkmodules; *p;p++) {
	if (strstr(ptr, *p)) return 1;
    };
    return 0;
}

MODULE = DynaLoader	PACKAGE = DynaLoader

BOOT:
    (void)dl_private_init(aTHXo);

void *
dl_load_file(filename,flags=0)
    char *		filename
    int			flags
    PREINIT:
    CODE:
  {
    DLDEBUG(1,PerlIO_printf(Perl_debug_log,"dl_load_file(%s):\n", filename));
    if (dl_static_linked(filename) == 0) {
	RETVAL = PerlProc_DynaLoad(filename);
    }
    else
	RETVAL = (void*) GetModuleHandle(NULL);
    DLDEBUG(2,PerlIO_printf(Perl_debug_log," libref=%x\n", RETVAL));
    ST(0) = sv_newmortal() ;
    if (RETVAL == NULL)
	SaveError(aTHXo_ "load_file:%s",
		  OS_Error_String(aTHXo)) ;
    else
	sv_setiv( ST(0), (IV)RETVAL);
  }

void *
dl_find_symbol(libhandle, symbolname)
    void *	libhandle
    char *	symbolname
    CODE:
    DLDEBUG(2,PerlIO_printf(Perl_debug_log,"dl_find_symbol(handle=%x, symbol=%s)\n",
		      libhandle, symbolname));
    RETVAL = (void*) GetProcAddress((HINSTANCE) libhandle, symbolname);
    DLDEBUG(2,PerlIO_printf(Perl_debug_log,"  symbolref = %x\n", RETVAL));
    ST(0) = sv_newmortal() ;
    if (RETVAL == NULL)
	SaveError(aTHXo_ "find_symbol:%s",
		  OS_Error_String(aTHXo)) ;
    else
	sv_setiv( ST(0), (IV)RETVAL);


void
dl_undef_symbols()
    PPCODE:



# These functions should not need changing on any platform:

void
dl_install_xsub(perl_name, symref, filename="$Package")
    char *		perl_name
    void *		symref 
    char *		filename
    CODE:
    DLDEBUG(2,PerlIO_printf(Perl_debug_log,"dl_install_xsub(name=%s, symref=%x)\n",
		      perl_name, symref));
    ST(0) = sv_2mortal(newRV((SV*)newXS(perl_name,
					(void(*)(pTHXo_ CV *))symref,
					filename)));


char *
dl_error()
    CODE:
    dMY_CXT;
    RETVAL = dl_last_error;
    OUTPUT:
    RETVAL

# end.
