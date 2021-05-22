# Building WRFV3
cd build_WRF
if [ ! -f "WRFV3.7.TAR.gz" ]; then
wget http://www2.mmm.ucar.edu/wrf/src/WRFV3.7.TAR.gz
fi
tar zxvf WRFV3.7.TAR.gz
cd WRFV3

echo 34 |  ./configure
./compile em_real > compile.log
ls -ls main/*.exe
if [ ! -f "main/wrf.exe" ]; then
	echo "WRF INSTALLED FAILURE."
	exit 1
else
	echo "WRF INSTALLED SUCCESS!"
fi

cd ..
# Building WPS
if [ ! -f "WPSV3.7.TAR.gz" ]; then
wget http://www2.mmm.ucar.edu/wrf/src/WPSV3.7.TAR.gz
fi
tar zxvf WPSV3.7.TAR.gz
cd WPS
./clean
echo 'export JASPERLIB=$DIR/grib2/lib' >> ~/.bashrc
echo 'export JASPERINC=$DIR/grib2/include' >> ~/.bashrc
source ~/.bashrc
echo 1 | ./configure
./compile > compile.log
ls -ls *.exe
if [ ! -f "geogrid.exe" ]; then
	echo "WPS INSTALLED FAILURE."
	exit 1
else
	echo "WPS INSTALLED SUCCESS!"
fi

