echo "Welcome! This Script will install the WRF3.7"
echo "First check gfortran compiler gcc and cpp"

# Building Libraries
current_dir=$(pwd)
build_WRF=$current_dir/build_WRF
mkdir -p $build_WRF
cd $build_WRF
mkdir -p libraries
libraries_lib=$build_WRF/libraries

cd $libraries_lib

echo '### WRF_libraries_path' >> ~/.bashrc
echo "export DIR=$PWD" >> ~/.bashrc
source ~/.bashrc

### Downloads libraries
if [ ! -f "netcdf-4.1.3.tar.gz" ]; then
wget http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/netcdf-4.1.3.tar.gz
fi

if [ ! -f "mpich-3.0.4.tar.gz" ]; then
wget http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/mpich-3.0.4.tar.gz
fi

if [ ! -f "libpng-1.2.50.tar.gz" ]; then
wget http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/libpng-1.2.50.tar.gz
fi

if [ ! -f "zlib-1.2.7.tar.gz" ]; then
wget http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/zlib-1.2.7.tar.gz
fi

if [ ! -f "jasper-1.900.1.tar.gz" ]; then
wget http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/jasper-1.900.1.tar.gz
fi

### install netcdf
echo 'export CC=gcc' >> ~/.bashrc
echo 'export CXX=g++' >> ~/.bashrc
echo 'export FC=gfortran' >> ~/.bashrc
echo 'export FCFLAGS=-m64' >> ~/.bashrc
echo 'export F77=gfortran' >> ~/.bashrc
echo 'export FFLAGS=-m64' >> ~/.bashrc
source ~/.bashrc

tar zxvf netcdf-4.1.3.tar.gz
cd netcdf-4.1.3
./configure --prefix=$DIR/netcdf --disable-dap --disable-netcdf-4 --disable-shared
make
make install
echo 'export PATH=$DIR/netcdf/bin:$PATH' >> ~/.bashrc
echo 'export NETCDF=$DIR/netcdf' >> ~/.bashrc
source ~/.bashrc

cd ..
### install MPICH
tar xzvf mpich-3.0.4.tar.gz
cd mpich-3.0.4
./configure --prefix=$DIR/mpich
make
make install
echo 'export PATH=$DIR/mpich/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
cd ..

### install zlib
echo 'export LDFLAGS=-L$DIR/grib2/lib' >> ~/.bashrc
echo 'export CPPFLAGS=-I$DIR/grib2/include' >> ~/.bashrc
source ~/.bashrc

tar xzvf zlib-1.2.7.tar.gz
cd zlib-1.2.7
./configure --prefix=$DIR/grib2
make
make install
cd ..
### install libpng
tar xzvf libpng-1.2.50.tar.gz
cd libpng-1.2.50
./configure --prefix=$DIR/grib2
make
make install
cd ..
### install JasPer
tar xzvf jasper-1.900.1.tar.gz
cd jasper-1.900.1
./configure --prefix=$DIR/grib2
make
make install
cd ..

echo "please reboot your machine and after booting run the wrf_installer.sh"
