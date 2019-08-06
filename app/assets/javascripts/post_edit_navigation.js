window.addEventListener("load", () => {
    const addImageBtn = document.querySelector('.nav-add-image');
    const fileField = document.querySelector('.nav-hidden-file-field');

    if (addImageBtn === null || fileField === null)
        return;

    addImageBtn.onclick = () => {
        fileField.click();
    };

    fileField.onchange = () => {
        const editArea = document.querySelector('.post-edit-field-desc');
        let files = fileField.files;

        if (files.length <= 0)
            return;

        
    }
}, false);