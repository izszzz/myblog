$(function(){
    const dataList = function(req, res) {
        $.ajax({
            url: "/posts/autocomplete",
            dataType: "json",
            type: "GET",
            cache: true,
            data: {
                q: {
                    title_or_tags_name_cont: req.term
                }
            },
            success: function(posts){
                const postTitles=posts.map(({title})=>title)
                res(posts)
            },
            error: function(){
                res([""])
            }
        })
    }

    $(".post-autocomplete").each((_, e)=>$(e).autocomplete({source: dataList, delay: 300, minLength: 2})
        .data("ui-autocomplete")._renderItem = function(ul, item){
            return $(`<a href="/posts/${item.id}" class="list-group-item list-group-item-action fab fa-${item.tag_list[0]} autocomplete-link">${item.title}</a>`)
                .appendTo(ul.addClass("list-group"))
        }
    )
})