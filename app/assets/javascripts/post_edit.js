const publishDialog = document.getElementById("publish-dialog");
const titleField = document.getElementById("post_title");
const titlePreview = document.getElementById("title-preview");
const descriptionField = document.getElementById("post_description");
const previewArea = document.getElementById("description-preview");
const publishButton = document.getElementById("btn-publish");
const closePublishDialog = document.getElementById("close-publish-dialog");
const publishPost = document.getElementById("publish-post");

const tagInput = document.querySelector('.tag-input');

const converter = new showdown.Converter({ headerLevelStart: 3 });

let curHtml = "";
let tagList = [];
const maxTagLength = 20;

// TODO : 페이지의 끝까지 가지 않고 여유공간을 두고 조정할 수 있도록 수정 필요
const resizeDescriptionField = () => {
    const offset = descriptionField.offsetHeight - descriptionField.clientHeight;
    descriptionField.style.height = 'auto';

    //const finalHeight = Math.max(descriptionField.scrollHeight + offset, previewArea.height);
    const finalHeight = descriptionField.scrollHeight + offset;
    descriptionField.style.height = finalHeight + 'px';
    previewArea.style.height = finalHeight + 'px';
}

const initPublishDialog = () => {
    const publishTitle = document.getElementById("publish-title");
    publishTitle.innerText = titleField.value;

    document.documentElement.classList.add("overflow-hidden");
};

titleField.oninput = e => {
    titlePreview.innerText = titleField.value;
};

descriptionField.addEventListener('input', e => {
    const newHtml = converter.makeHtml(e.target.value);
    if (curHtml !== newHtml) {
        curHtml = newHtml;
        previewArea.innerHTML = curHtml;
    }

    resizeDescriptionField();
});

publishButton.onclick = e => {
    e.preventDefault();

    publishDialog.style.display = "flex";
    initPublishDialog();
};

publishPost.onclick = e => {
    const form = document.getElementById("post-form");
    const tagField = document.getElementById("post_tags");
    tagField.value = tagList;

    form.submit();

    //Rails.fire(form, "submit");
};

closePublishDialog.onclick = e => {
    publishDialog.style.display = "none";

    document.documentElement.classList.remove("overflow-hidden");
};

// TODO : 글자 수 제한, 태그 중복, 태그 수 제한 등의 예외에 툴팁을 띄워줘야함.
tagInput.onkeypress = e => {
    if (e.keyCode === 13) {
        e.preventDefault();

        const tag = tagInput.innerText;
        if (!isValidTag(tag)) {
            return;
        }

        // const tagElem = "<%= j render 'partials/tag_element', locals: { tag_name: '${tag}' } %>"
        e.target.insertAdjacentElement('beforebegin', createTagElement(tag));
        tagInput.innerText = "";
        return;
    }

    if (tagInput.innerText.length >= maxTagLength) {
        e.preventDefault();
    }
}

const createTagElement = tag => {
    const tagElem = document.createElement("div");
    tagElem.innerText = `#${tag}`;
    tagElem.classList = ["tag-element"];
    tagList.push(tag);
    
    return tagElem;
}

const isValidTag = tag => {
    if (tagList.length >= 5) {
        return false;
    }

    if (tagList.includes(tag)) {
        return false;
    }

    // TODO : 공백 등의 예외처리 필요

    return true;
}

(() => {
    if (descriptionField.value !== "") {
        curHtml = converter.makeHtml(descriptionField.value);
        previewArea.innerHTML = curHtml;
    }

    titlePreview.innerText = titleField.value;
    resizeDescriptionField();
})();

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