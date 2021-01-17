// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
// #= require social-share-button
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery3
//= require jquery-ui/widgets/autocomplete
//= require popper
//= require bootstrap-sprockets
//= require bootstrap-tagsinput
//= require_tree .

// autocomplete
$(document).on("turbolinks:load", function(){
    const dataList = function(req, res) {
        console.log(req)
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
                res(posts)
            },
            error: function(){
                res([""])
            }
        })
    }
    $("#post-autocomplete").each((_, e)=>$(e).autocomplete({source: dataList, delay: 300, minLength: 2})
        .data("ui-autocomplete")._renderItem = function(ul, item){
            return $(`<a href="/posts/${item.id}" class="list-group-item list-group-item-action devicon-${item.tag_list[0]}-plain autocomplete-link text-truncate w-100">${item.title}</a>`)
                .appendTo(ul.addClass("list-group overflow-hidden"))
        }
    )
})