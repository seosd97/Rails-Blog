window.addEventListener("load", () => {
    const descEditField = document.querySelector('.post-edit-field-desc');
    const descHiddenField = document.querySelector('.post-edit-desc-hidden');

    if (descEditField === null || descHiddenField === null)
        return;

    if (descHiddenField.value !== '') {
        descEditField.innerText = descHiddenField.value;
    }

    const publishBtn = document.querySelector('.publish-button');
    if (publishBtn !== null) {
        publishBtn.onclick = () => {
            descHiddenField.value = descEditField.innerText;
            const form = document.querySelector('.post-edit-form');
            Rails.fire(form, 'submit');
        };
    }
}, false);

// NOTE : safari에서 BFCache를 사용하기 때문에 최초 1회 후에는 페이지에서 나갈 때 체크해주지 않음.
//        그래서 onpageshow에서 persisted(BFCache를 사용하여 로드했는지 체크하는 변수)를 사용하여 체크해줘야함.
//        하지만 chrome과 safari에서 persisted에 버그가 있기 때문에 정확한 동작을 하지 않음.
//        window.performance.navigation.type이 2이면 BFCache를 사용한 것이라고 하는데 동작하지 않음.

// window.addEventListener("pageshow", (e) => {
//     if (e.persisted || (window.performance && window.performance.navigation.type == 2)) {
//         console.log("cached page");
//         window.location.reload();
//     }
// }, false);

window.addEventListener("beforeunload", (e) => {
    if (e) {
        e.returnValue = "close?";
    }

    return "close?";
}, false);