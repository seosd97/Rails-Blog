const titleField = document.getElementById("post_title");
const titlePreview = document.getElementById("title-preview");
const descriptionField = document.getElementById("post_description");
const previewArea = document.getElementById("description-preview");
const publishButton = document.getElementById("publish-post");

const converter = new showdown.Converter({ headerLevelStart: 3 });

let curHtml = "";

const resizeDescriptionField = () => {
    const offset = descriptionField.offsetHeight - descriptionField.clientHeight;
    descriptionField.style.height = 'auto';
    descriptionField.style.height = (descriptionField.scrollHeight + offset) + 'px';
}

publishButton.onclick = e => {
    e.preventDefault();

    const form = document.getElementById("post-form");
    form.submit();

    //Rails.fire(form, "submit");
};

titleField.oninput = e => {
    titlePreview.innerText = titleField.value;
};

// TODO : 페이지의 끝까지 가지 않고 여유공간을 두고 조정할 수 있도록 수정 필요
window.onload = resizeDescriptionField;
descriptionField.addEventListener('input', e => {
    resizeDescriptionField();

    const newHtml = converter.makeHtml(e.target.value);
    if (curHtml == newHtml)
        return;

    curHtml = newHtml;
    previewArea.innerHTML = curHtml;
});

// TODO : 참고를 위해 지우지 않음
// hiddenFileField.onchange = () => {
//     const reader = new FileReader();
//     reader.readAsDataURL(hiddenFileField.files[0]);
//     console.log(hiddenFileField.files[0]);
//     reader.onload = () => {
//         console.log(reader.result);
//     }
// }

// NOTE : safari에서 BFCache를 사용하기 때문에 최초 1회 후에는 페이지에서 나갈 때 체크해주지 않음.
//        그래서 onpageshow에서 persisted(BFCache를 사용하여 로드했는지 체크하는 변수)를 사용하여 체크해줘야함.
//        하지만 chrome과 safari에서 persisted에 버그가 있기 때문에 정확한 동작을 하지 않음.
//        window.performance.navigation.type이 2이면 BFCache를 사용한 것이라고 하는데 동작하지 않음.
//        포스트 작성 완료 후 Publish를 했을 때는 알림 팝업이 뜨지 않도록 해야함.

// window.addEventListener("pageshow", (e) => {
//     if (e.persisted || (window.performance && window.performance.navigation.type == 2)) {
//         console.log("cached page");
//         window.location.reload();
//     }
// }, false);

// window.addEventListener("beforeunload", (e) => {
//     if (e) {
//         e.returnValue = "close?";
//     }

//     return "close?";
// }, false);