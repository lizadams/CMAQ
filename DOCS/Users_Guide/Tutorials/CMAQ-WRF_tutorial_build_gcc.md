## CMAQ-WRF Tutorial ## 

### Procedure to build the WRF-CMAQ model using gnu compiler: ###

### Step 1:  Download WRF 4.1.1
   - Please register at the WRF User site https://www2.mmm.ucar.edu/wrf/users/download/get_source.html
   - use the second method to obtain the WRF-Modeling System source code by downloading an archived version from github
   - download version 4.1.1 from https://github.com/wrf-model/WRF/releases/tag/v4.1.1
   - extract the tar.gz file
   
   ```
   tar -xzvf WRF-4.1.1.tar.gz
   ```
   
   - follow the following instructions on how to configure download and install the netCDF Fortran and C libraries and put them in a combined directory
   https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compilation_tutorial.php
   
   - Before configuring WRF, the compiler module that you are using needs to be loaded so that the compiler paths are correct:
   - example
   
   ```
   module load openmpi_4.0.1/gcc_9.1.0
   ```

   - set the following environment variables including the path to your combined netcdf libraries, include files
    
    
    setenv NETCDF /path_to_directory/Build_WRF/LIBRARIES/netcdf_combined
    setenv CC gcc
    setenv CXX g++
    setenv FC gfortran
    setenv FCFLAGS -m64
    setenv F77 gfortran
    setenv FFLAGS -m64
    
    
    - check to see that the path to each compiler is defined using
    
    ```
    which gcc
    which g++
    which gfortran
    ```
    
    If they are not found, ask for assistance from your system administrator, 
    or if you know the path then sepcify it using the environment varialbe
    
    ```
    setenv CC /nas/longleaf/apps/gcc/9.1.0/bin/gcc
    ```
    

   -  Configure WRF by typing ./configure (this creates a configure.wrf file)
   
   ```
   ./configure |& tee ./configure.log
   ```

#### If you have never done WRF configure before, here are some guidelines:

      - choose the dmpar option with the appropriate compiler platform

      - in the compile for nesting section, choose the default value

### Step 2: Download IOAPI_3.2 and install it.
     - set the IOAPI environment variable to the path where it has been installed

### Step 3: Install CMAQ
     - follow these instructions to download the code, then use the modifications in Step 4
     
https://github.com/USEPA/CMAQ/blob/master/DOCS/Users_Guide/Tutorials/CMAQ_UG_tutorial_benchmark.md

### Step 4: Modify the bldit_cctm.csh to uncomment the following options:

     
      ```
      set MakeFileOnly                      #> uncomment to build a Makefile, but do not compile;
      ```
      
      
      
```
      #> Two-way WRF-CMAQ 
set build_twoway                      #> uncomment to build WRF-CMAQ twoway; 
```

### Run the bldit_cctm.csh script
```
./bldit_cctm.csh |& tee bldit_cctm_twoway.log
```
      

#### After running the blidit script, copy BLD_CCTM_V531_gcc into WRFV411/cmaq directory.

example {depends on the location of your WRF-4.1.1 directory}:

```
cp -rp BLD_CCTM_v531_gcc ../../../WRF-4.1.1/cmaq
```

### Step 5: Download twoway.tar.gz and unzip it. A twoway directory is formed and move it inside WRFV411 as well.

- The WRFv4.1.1-CMAQv5.3.1 coupled model is released as a tarball 

[Link to WRFv4.1.1-CMAQv5.3.1 Coupled_Model on Google Drive](https://drive.google.com/open?id=10wFNch1MkI49ZjD2XD6wK2xzDWOav2zY)

The coupled model is also available as a tarball (twoway.tar.gz) from the the US EPA annoymous ftp server:

[ftp://newftp.epa.gov/exposure/CMAQ/V5_3/WRF-CMAQ_Coupled_Mode](https://bit.ly/3cuoDyi)



### Step 6: Go into directory WRFV411 and execute the following command:

    ```
    twoway/assemble
    ```
    
    - This command will update all necessary files in WRF and CMAQ to create the twoway model. 
    - You can find the original files inside twoway/misc/orig directory.

### Step 7: Compile the twoway model by typing "./compile em_real >& mylog"
    - If compilation is done successfully, you can find main/wrf.exe file.
