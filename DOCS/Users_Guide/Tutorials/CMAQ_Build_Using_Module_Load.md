1. Download netCDF-C from the following website https://www.unidata.ucar.edu/downloads/netcdf/index.jsp

```
wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-c-4.7.0.tar.gz
```

2. Untar

```
tar -tzvf netcdf-c-4.7.0.tar.gz
```

3. Verify that no modules are currently loaded

```
module list
```

4. See what modules are available on your compute server

```
module avail
```

5. Load module environment for the compiler and mpi package

```
module load openmpi_4.0.1/gcc_9.1.0
```

6. Review the installation instructions for netcdf-c-4.7.0 for building Classic netCDF

```
more INSTALL.md
```

7. Create a target installation directory that includes the loaded module environment name

8. Run the configure command

```
./configure --prefix=/proj/ie/proj/staff/lizadams/netcdf-c-4.7.0/openmpi_4.0.1_gcc_9.1.0 --disable-netcdf-4 --disable-dap
```

9. Check that the configure command worked correctly

```
make check install
```

## Verify that the following message is obtained
+-------------------------------------------------------------+
| Congratulations! You have successfully installed netCDF!    |

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
mkdir openmpi_4.0.1_gcc_9.1.0
```
5. Review the installation document http://www.unidata.ucar.edu/software/netcdf/docs/building_netcdf_fortran.html

6. Set the environment variable NCDIR
```
setenv NCDIR /proj/ie/proj/staff/lizadams/netcdf-c-4.7.0/openmpi_4.0.1_gcc_9.1.0
```
7. set the CC environment variable to use the gcc and gfortran compilers
```
which gcc
which gfortran

setenv CC /nas/longleaf/apps/gcc/9.1.0/bin/gcc
setenv FC /nas/longleaf/apps/gcc/9.1.0/bin/gfortran
```
8. set your LD_LIBRARY_PATH to include the netcdf-C library path for netCDF build
```
setenv NCDIR /proj/ie/proj/staff/lizadams/netcdf-c-4.7.0/openmpi_4.0.1_gcc_9.1.0
setenv LD_LIBRARY_PATH ${NCDIR}/lib:${LD_LIBRARY_PATH}
```
9. check your LD_LIBRARY_PATH
```
echo $LD_LIBRARY_PATH
```
10. set the install directory for netCDF fortran
```
setenv NFDIR /proj/ie/proj/staff/lizadams/netcdf-fortran-4.4.5/openmpi_4.0.1_gcc_9.1.0

setenv CPPFLAGS -I${NCDIR}/include
setenv LDFLAGS -L${NCDIR}/lib
```
echo $LD_LIBRARY_PATH
```
11. Run the configure command
```
./configure --prefix=${NFDIR} --disable-fortran-type-check
```

12. Run the make check command

```
make check
```

