## Install netCDF-C

1. Download netCDF-C from the following website https://www.unidata.ucar.edu/downloads/netcdf/index.jsp

```
wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-c-4.7.0.tar.gz
```

2. Untar the file 

```
tar -xzvf netcdf-c-4.7.0.tar.gz
```

3. Change directories into the package
```
cd netcdf-c-4.7.0
```

3. Verify that no modules are currently loaded using module commands. 

```
module list
```

4. See what modules are available on your compute server use the command: 

```
module avail
```

5. Load module environment for a compiler (Intel|GCC|PGI) and mpi package corresponding to that compiler (e.g. openmpi).

```
module load intel18.2
module load openmpi_3.1.4/intel_18.2
```

6. Review the installation instructions for netcdf-c-4.7.0 for building Classic netCDF

```
more INSTALL.md
```

7. Create a target installation directory that includes the loaded module environment name. 

```
mkdir $cwd/netcdf-c-4.7.0-intel18.2
```

8. Run the configure --help command to see what settings can be used for the build.
```
./configure --help
```

9. Set the Compiler environment variables

First find the path to the CC compiler on your system using the which command
```
which icc
```
Next, replace the following path in the setenv command below to use the path to your CC compiler

```
setenv CC /urs/local/apps/intel/18.2/bin/icc
```

Find the path to the Fortran compiler on your ssystem using the which command
```
which ifort
```
Next, replace the following path in the setenv command below to use the path to the Fortran compiler on your system
```
setenv FC /urs/local/apps/intel/18.2/bin/ifort
```

Find the path to the CXX compiler on your system using the which command
```
which icpc
```
Next, replace the following path in the setenv command below to use the path to the CXX compiler on your system:
```
setenv CXX /urs/local/apps/intel/18.2/bin/icpc
```

10. Run the configure command

```
./configure --prefix=$cwd/netcdf-c-4.7.0-intel18.2 --disable-netcdf-4 --disable-dap
```

11. Check that the configure command worked correctly

```
make check install |& tee make.install.log.txt
```

12. Verify that the following message is obtained at the end of your make.install.log.txt file

```
| Congratulations! You have successfully installed netCDF!    |
```

## Install netCDF-Fortran

1. Download netCDF-Fortran from the following website https://www.unidata.ucar.edu/downloads/netcdf/index.jsp

```
wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-fortran-4.4.5.tar.gz 
```

2. Untar the tar.gz file

```
tar -xzvf netcdf-fortran-4.4.5.tar.gz
```

3. Change directories to netcdf-fortran-4.4.5

```
cd netcdf-fortran-4.4.5
```

4. Make an install directory that matches the name of your loaded module environment

```
mkdir $cwd/netcdf-fortran-4.4.5-intel18.2
```

5. Review the installation document http://www.unidata.ucar.edu/software/netcdf/docs/building_netcdf_fortran.html

6. Set the environment variable NCDIR

```
setenv NCDIR $cwd/netcdf-c-4.7.0-intel18.2
```

7. Set the CC environment variable to use the intel compilers

First find the path to the CC compiler on your system using the which command
```
which icc
```
Next, replace the following path in the setenv command below to use the path to your CC compiler
```
setenv CC /urs/local/apps/intel/18.2/bin/icc
```
Find the path to the Fortran compiler on your ssystem using the which command
```
which ifort
```
Next, replace the following path in the setenv command below to use the path to the Fortran compiler on your system
```
setenv FC /urs/local/apps/intel/18.2/bin/ifort
```
Find the path to the CXX compiler on your system using the which command
```
which icpc
```
Next, replace the following path in the setenv command below to use the path to the CXX compiler on your system:
```
setenv CXX /urs/local/apps/intel/18.2/bin/icpc
```

8. Set your LD_LIBRARY_PATH to include the netcdf-C library path for netCDF build

```
setenv NCDIR /home/netcdf-c-4.7.0-intel18.2
setenv LD_LIBRARY_PATH ${NCDIR}/lib:${LD_LIBRARY_PATH}
```

9. Check your LD_LIBRARY_PATH

```
echo $LD_LIBRARY_PATH
```

10. Set the install directory for netCDF fortran

```
setenv NFDIR /home/netcdf-fortran-4.4.5-intel18.2
setenv CPPFLAGS -I${NCDIR}/include
setenv LDFLAGS -L${NCDIR}/lib
```

11. check your LD_LIBRARY_PATH environment variable

```
echo $LD_LIBRARY_PATH
```

12. Run the configure command

```
./configure --prefix=${NFDIR}
```

13. Run the make check command

```
make check |& tee make.check.log.txt
```

Output if successful:

```
Testsuite summary for netCDF-Fortran 4.4.5
==========================================
# TOTAL: 6
# PASS:  6
```

14. Run the make install command

```
make install |& tee ./make.install.log.txt
```

Output successful if you see:

```
Libraries have been installed in:
   
   /home/netcdf-fortran-4.4.5-intel18.2

If you ever happen to want to link against installed libraries
in a given directory, LIBDIR, you must either use libtool, and
specify the full pathname of the library, or use the '-LLIBDIR'
flag during linking and do at least one of the following:
   - add LIBDIR to the 'LD_LIBRARY_PATH' environment variable
     during execution
   - add LIBDIR to the 'LD_RUN_PATH' environment variable
     during linking
   - use the '-Wl,-rpath -Wl,LIBDIR' linker flag
   - have your system administrator add LIBDIR to '/etc/ld.so.conf'
```

15. set your LD_LIBRARY_PATH to include the netcdf-Fortran library path for netCDF build

```
setenv NFDIR /home/netcdf-fortran-4.4.5-intel18.2
setenv LD_LIBRARY_PATH ${NFDIR}/lib:${LD_LIBRARY_PATH}
```
(may need to add the NCDIR and NFDIR to .cshrc)

16. create a netcdf_combined directory, and copy the netcdf C and netcdf Fortran libraries to it

```
cd ../LIBRARIES
mkdir netcdf_combined
cp -rp ../netcdf-c-4.7.0/netcdf-c-4.7.0-intel18.2/* .
cp -rp ../netcdf-fortran-4.4.5/netcdf-fortran-4.4.5-intel18.2/* .
```

## Install I/O API

Note The complete I/O API installation guide can be found at either of the following:

https://www.cmascenter.org/ioapi/documentation/all_versions/html/AVAIL.html

or

https://cjcoats.github.io/ioapi/AVAIL.html

1. Download I/O API

```
git clone https://github.com/cjcoats/ioapi-3.2
cd ioapi-3.2         ! change directory to ioapi-3.2
git checkout -b 20200828   ! change branch to 20200828 for a tagged release version
```

2.  Set the following environment variables

```
setenv HOME /proj/ie/proj/CMAS/CMAQ/CMAQv5.3.2_rel2/openmpi_3.1.4_intel_18.2/LIBRARIES/
setenv BIN      Linux2_x86_64ifort_openmpi_3.1.4_intel18.2
setenv CPLMODE  nocpl
```


3. Change the NCFLIBS in the Makefile

```
cp Makefile.template Makefile
gedit Makefile
NCFLIBS    = /proj/ie/proj/CMAS/CMAQ/CMAQv5.3.2_rel2/openmpi_3.1.4_intel_18.2/LIBRARIES/netcdf_combined/lib -lnetcdff -lnetcdf 
```

4. Copy Makefile.nocpl to Makefile in m3tools directory

```
cd m3tools
cp Makefile.nocpl Makefile
```

5. Copy an existing Makeinclude file to have this BIN name at the end

```
cd ioapi
cp Makeinclude.Linux2_x86_64ifort Makeinclude.Linux2_x86_64ifort_openmpi_3.1.4_intel18.2
```

6. Edit the Makeinclude file, lines 27 and 28 to use -qopenmp instead of -openmp

```
OMPFLAGS  = -qopenmp
OMPLIBS   = -qopenmp
```

7. Set the environment variable BIN

```
setenv BIN Linux2_x86_64ifort_openmpi_3.1.4_intel18.2
```

8. Create a BIN directory under the ioapi-3.2 directory

```
cd ..
mkdir $BIN
```

9. Run the make command to compile and link the ioapi library

```
make all |& tee make.log
```

10. Change directories to the $BIN dir and verify that both the libioapi.a and the m3tools were successfully built

```
cd $BIN
ls -lrt libioapi.a
ls -rlt m3xtract
```

11. After successfull completion of this tutorial, the user is now ready to proceed to the [CMAQ Installation & Benchmarking Tutorial](./CMAQ_UG_tutorial_benchmark.md). 

