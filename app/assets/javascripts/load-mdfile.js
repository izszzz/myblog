// mdfile
$(document).on("turbolinks:load", function(){
    const fileReader = new FileReader()
    const mdFileField = document.getElementById("mdFileField")
    const mdTextArea = document.getElementById("mdTextArea")

    mdFileField.addEventListener("change", function(e){
        fileReader.readAsText(e.target.files[0])
        fileReader.onload = function(){
            mdTextArea.value = fileReader.result
        }
    })
})