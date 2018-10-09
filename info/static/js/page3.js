/**
 * Created by 7z1 on 2018/9/27.
 */
var currentCid = 1; // 当前分类 id
var cur_page = 2; // 当前页
var total_page = 1;  // 总页数
var data_querying = true;   // 是否正在向后台获取数据


function updateNewsData() {
    //  更新新闻数据
    var params = {
        "page": cur_page,
        "cid": currentCid,
    };
    $.get("/time_news_list", params, function (resp) {
        data_querying = false
        if (resp) {
            // 显示数据
            total_page = resp.totalPage
            if (cur_page == 1) {
                $("#list").html('')
            }
            cur_page += 1
            var content = ''
            for (var i=0;i<resp.data.new_li.length;i++) {
                var news = resp.data.new_li[i]
                content += '<li>'
                content += '<span>' + news.create_date + '</span>'
                content += '<a href="/news/'+ news.id +'" title="'+ news.title + '">' + news.title + '</a>'
                content += '</li>'
                // content += '<div class="pagelist"><a class="allpage"><b>' + total_page + '</b></a>&nbsp;&nbsp;<a href="#" class="curPage">1</a>&nbsp;&nbsp;<a href="#" onclick="updateNewsData()">2</a>&nbsp;&nbsp;<a href="#" onclick="updateNewsData()">下一页</a></div>'
                // $("#list").append(content)
            }
            // console.log(content)
            $("#list").html(content)
        }
    })
}
