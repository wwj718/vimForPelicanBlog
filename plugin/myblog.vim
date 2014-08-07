" 双引号开头表示Vim的注释
" 函数使用VimL定义的， 我们可以在函数定义中混用 VimL和 Python
function! 	MyBlog(arg1)
 
" 我像下面这行这样开始写 python 代码
 
python << EOF

# Vim 模块包含了所有从python访问vim的接口。 我们需要用requests写访问网络服务的部分。
import requests,xmltodict
from pyquery import PyQuery as pq
import vim

getnumber = vim.eval("a:arg1")

try:
    # 得到帖子 并分析feed
    feed_response = requests.get("http://wwj718.gitcafe.com/feeds/all.rss.xml").content
    doc = xmltodict.parse(feed_response)
    articles = doc["rss"]["channel"]["item"]
    # vim.current.buffer 就是当前缓冲区。它是一个类似于列表的对象
    # 每行是一个list的一项。 我们可以对它们循环遍历、删除、修改等等。
    # 我们在这里删除当前缓冲区的所有内容
    del vim.current.buffer[:]
    #使用说明
    vim.current.buffer.append(36*"="+u'\u4f7f\u7528\u8bf4\u660e'+36*"=")
    vim.current.buffer.append("@author:wuwenjie")
    vim.current.buffer.append("@Email:wuwenjie718@gmail.com")
    vim.current.buffer.append(u"\u8f93\u5165 :call MyBlog('all') \u83b7\u53d6\u6587\u7ae0\u5217\u8868")
    vim.current.buffer.append(u"\u8f93\u5165 :call MyBlog('\u6587\u7ae0\u7f16\u53f7') \u83b7\u53d6\u6587\u7ae0\u5185\u5bb9\uff0c\u5982 :call MyBlog('3')"
    )
    vim.current.buffer.append(80*"=")


    # 为了美观，我们在顶部加入几行。
    #vim.current.buffer[0] = 80*"-"
    if getnumber == 'all':
        for i,article in enumerate(articles):
            # 接下来几行，我们放帖子的详细内容。
            title = article["title"]
            link = article["link"]
            pubDate = article["pubDate"]
            # 我们一行一行地插入到缓冲区里
            #文章编号
            vim.current.buffer.append(u"\u6587\u7ae0\u7f16\u53f7 : %s"%(i))
            # 标题和链接
            vim.current.buffer.append("%s [%s]"%(title, link,))
            # 日期，为了正常显示，用编码
            vim.current.buffer.append(u'\u65e5\u671f'+":-- %s"%(pubDate))
            vim.current.buffer.append(u'\u4f5c\u8005'+": wuwenjie")
            #for p in description :
            #    vim.current.buffer.append(p.text)
            # 为了好看我们再插入一些 "-"
            vim.current.buffer.append(80*"-")
    else:
        article = articles[int(getnumber)]
        title = article["title"]
        link = article["link"]
        pubDate = article["pubDate"]
        description = pq(article["description"]).find("p")
        # 标题和链接
        vim.current.buffer.append("    %s [%s]"%(title, link,))
        # 日期，为了正常显示，用编码
        vim.current.buffer.append(u'\u65e5\u671f'+":-- %s"%(pubDate))
        vim.current.buffer.append(u'\u4f5c\u8005'+"wuwenjie")
        #加入简介
        vim.current.buffer.append(80*"*")
        for p in description:
            vim.current.buffer.append(p.text)
        vim.current.buffer.append(80*"-")

except Exception, e:
    print e
 
EOF
" Python代码在这里结束。 我们可以再继续写 VimL 或者 python代码。

endfunction