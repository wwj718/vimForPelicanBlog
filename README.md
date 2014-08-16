#使用vim访问Pelican博客

#使用方法
##安装插件
*  pip install -r requirements.txt
*  使用[Vundle](https://github.com/gmarik/Vundle.vim)安装插件即可
  *  安装完Vandel 后 在~/.vimrc中添加Plugin 'wwj718/vimForPelicanBlog'

##使用
*  编辑~/.vimrc 设置你的博客url,添加如下内容：let g:BLOGURL = 'http://YOUR_BLOG_URL:'
*  进入vim, :call Blog('all')

##特性
将博客内容解析为md格式，显示在vim中，方便直接保存

###todo
*  把它扩展一个markdown工具，浏览网页的markdown版，随时保存网页的markdown版本
*  使用python文本分析，高亮关键字
