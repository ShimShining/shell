#! /usr/bin/bash

#查找并删除扩展名为.php的文件
find ./tmp -name "*.php" -exec rm -f {} \;

if [ $? -eq 0 ]; then
	echo "the file have been deleted successfully."
else
	echo "Failed to delete files."
fi
