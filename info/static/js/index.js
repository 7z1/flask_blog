var currentCid = 1; // 当前分类 id
var cur_page = 1; // 当前页
var total_page = 1;  // 总页数
var data_querying = true;   // 是否正在向后台获取数据


$(function () {
    // 界面加载完成之后去加载新闻数据
    updateNewsData()

    // 首页分类切换
    $('#topnav li a').click(function () {
        // 取到指定分类的cid
        var clickCid = $(this).parent().attr('data-cid')
        // 遍历所有的 li 移除身上的选中效果
        // $('.menu li').each(function () {
        //     $(this).removeClass('active')
        // })
        // 给当前分类添加选中的状态
        // $(this).addClass('active')
        // 如果点击的分类与当前分类不一致
        if (clickCid != currentCid) {
            // 记录当前分类id
            currentCid = clickCid
            // 重置分页参数
            cur_page = 1
            total_page = 1
            updateNewsData()
        }
    })

    //页面滚动加载相关
    $(window).scroll(function () {

        // 浏览器窗口高度
        var showHeight = $(window).height();

        // 整个网页的高度
        var pageHeight = $(document).height();

        // 页面可以滚动的距离
        var canScrollHeight = pageHeight - showHeight;

        // 页面滚动了多少,这个是随着页面滚动实时变化的
        var nowScroll = $(document).scrollTop();

        if ((canScrollHeight - nowScroll) < 100) {
            // 判断页数，去更新新闻数据

            if (!data_querying) {
                data_querying = true

                // 如果当前页数据如果小于总页数，那么才去加载数据
                if (cur_page < total_page) {
                    cur_page += 1
                    // 去加载数据
                    updateNewsData()
                }

            }
        }
    })
})

function updateNewsData() {
    // 更新新闻数据
    var params = {
        "cid": currentCid,
        "page": cur_page
    }
    $.get("/news_list", params, function (resp) {
        // 数据加载完毕，设置【正在加载数据】的变量为 false 代表当前没有在加载数据
        data_querying = false
        if (resp.errno == "0") {
            // 给总页数据赋值
            total_page = resp.data.total_page
            // 代表请求成功
            // 清除已有数据
            if (cur_page == 1) {
                $(".blogsbox").html("")
            }

            // 添加请求成功之后返回的数据

            // 显示数据
            for (var i=0;i<resp.data.new_li.length;i++) {
                var news = resp.data.new_li[i]
                var content = '<div class="blogs" data-scroll-reveal="enter bottom over 1s" >'
                content += '<h3 class="blogtitle"><a href="./news/' + news.id + '" target="_blank">' + news.title + '</a></h3>'
                content += '<span class="blogpic"><a href="/news/' + news.id + '" title=""><img src="' + news.index_image_url + '" alt=""></a></span>'
                content += '<p class="blogtext">' + news.digest + '</p>'
                content += '<div class="bloginfo">' + '<ul>' + '<li class="author"><a href="/">' + news.source + '</a></li>'
                content += '<li class="lmname"><a href="/">' + news.category.name + '</a></li>'
                content += '<li class="timer">' + news.create_time + '</li>'
                content += '<li class="view"><span>' + news.clicks + '</span>已阅读</li>'
                content += '<li class="like">' + news.like_count + '</li></ul></div></div>'
                $(".blogsbox").append(content)
            }
        }else {
            // 请求失败
            alert(resp.errmsg)
        }
    })
}
