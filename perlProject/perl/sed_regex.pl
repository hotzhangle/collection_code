find . -name "*.awk" | sed  's#.*\/##'  | sed 's@\.awk@@'
sed -e 'pattern' -e 'pattern' myfile 可以匹配两个以上的条件
find . -name "*.awk" | sed  -e 's#.*\/##'  -e  's@\.awk@@'
以上两条命令实践证明均能够取得文件名
http://wangbixi.com/x2923/comment-page-1/
http://blog.csdn.net/gua___gua/article/details/49304699
http://blog.chinaunix.net/uid-10540984-id-2954393.html
http://www.cnblogs.com/zd520pyx1314/p/6061337.html
