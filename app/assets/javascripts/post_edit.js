window.onload = () => {
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
}