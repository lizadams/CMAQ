#! /bin/csh -f

# ==================== Build Script for BLDMAKE ===================== #
# Usage: bldit_bldmake.csh                                            #
# Requirements: I/O API & netCDF libraries; a Fortran compiler        #
#                                                                     #
# To report problems or request help with this script/program:        #
#             http://www.cmascenter.org                               #
# =================================================================== #

#> Recompile BLDMAKE from source if requested or if it does not exist
  if ( $?CompileBLDMAKE || ! -f $BLDER ) then

     if (${compiler} == pgi) then
        # this addition flag is for handling backslash in quoted string properly
        set add_flags = -Mbackslash
     else
        set add_flags = 
     endif

     #> Set BLDER to Default Path
     set BLDEXE = "bldmake_${compilerString}.exe"
     set BLDDIR = "$CMAQ_HOME/UTIL/bldmake"
     setenv BLDER "${BLDDIR}/${BLDEXE}"
     
     #> Make bldmake directory if it does not exist
     if ( ! -d $BLDDIR ) mkdir -pv $BLDDIR
  
     #> Compile BLDMAKE source code
     set BLDSRCDIR = "$CMAQ_REPO/UTIL/bldmake/src"
     set flist = (\
          cfg_module\
          bldmake\
          parser\
          utils )
  
     #> Clean Destination BLDMAKE directory
     cd $BLDDIR
     rm *.o *.mod $BLDER
  
     #> Create Object Files
     cd $BLDSRCDIR
     foreach file ( $flist )
        $myFC -c $add_flags $myFFLAGS $file.f -o $BLDDIR/$file.o
     end
  
     #> Compile BLDMAKE
     cd $BLDDIR
     $myFC *.o -o $BLDEXE
     if( ! -e $BLDEXE ) then
         echo " "; echo " ***ERROR*** BLDMAKE Compile failed"; echo " "
         exit 1
     endif
     chmod 755 $BLDEXE
     echo " "; echo " Finish building $BLDEXE "
  
  endif
 
 exit
