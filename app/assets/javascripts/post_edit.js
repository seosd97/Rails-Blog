const descEditField = document.querySelector(".post-edit-field-desc");
const imageField = document.querySelector(".image-field");
const imageHidden = document.querySelector(".hidden-file-field");

descEditField.addEventListener("input", e => {
    const offset = descEditField.offsetHeight - descEditField.clientHeight;
    descEditField.style.height = 'auto';
    descEditField.style.height = (descEditField.scrollHeight + offset) + 'px';
});

const publishBtn = document.querySelector(".publish-button");
if (publishBtn !== null) {
    publishBtn.onclick = () => {
        imageField.files = imageHidden.files;
        const form = document.querySelector(".post-edit-form");
        Rails.fire(form, "submit");
    };
}

const uploadImageBtn = document.querySelector(".upload-image-button");
if (uploadImageBtn !== null) {
    uploadImageBtn.onclick = () => {
        showPreviewBar();
    };
}

const uploadImage = document.querySelector(".upload-image");
const hiddenFileField = document.querySelector(".hidden-file-field");
uploadImage.onclick = () => {
    hiddenFileField.click();
};

hiddenFileField.onchange = () => {
    const reader = new FileReader();
    reader.readAsDataURL(hiddenFileField.files[0]);
    //console.log(hiddenFileField.files[0]);
    // reader.onload = () => {
    //     console.log(reader.result);
    // }
}

// NOTE : 이미지 프리뷰 창 이벤트

// TODO : 추후 연출을 위해 애니메이션으로 처리를 해줘야 함.
const imagePreviewBar = document.querySelector(".image-preview-bar");

function showPreviewBar() {
    imagePreviewBar.style.display = "block";
}

function hidePreviewBar() {
    imagePreviewBar.style.display = "none";
}

const previewCloseButton = document.querySelector(".preview-close");
previewCloseButton.onclick = () => {
    hidePreviewBar();
};

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