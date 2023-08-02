new=$(ls -d /home/data/EGA/IMmotion151/raw/*/)
dir=/home/data/IO_RNA/EGA_IMmotion151/redownload_data/

mkdir -p $dir

for i in $new
do
    echo "Copying data in $i to $dir"
    cp $i/* $dir
done