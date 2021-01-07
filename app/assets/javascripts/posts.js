$(function(){
    const dataList = function(req, res) {
        console.log(req)
        $.ajax({
            url: "/posts/autocomplete/?utf8=✓&q%5Btitle_or_tags_name_or_categories_name_cont%5D="+req.term,
            dataType: "json",
            type: "GET",
            cache: true,
            success: function(posts){
                console.log(posts)
                const postTitles=posts.map(({title})=>title)
                res(postTitles)
            },
            error: function(){
                res([""])
            }
        })
    }

    $(".post-autocomplete").each((_, e)=>$(e).autocomplete({source: dataList, delay: 300, minLength: 2}))
})