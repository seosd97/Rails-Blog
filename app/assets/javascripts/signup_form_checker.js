const nameField = document.getElementById("signup-name-field");
const emailField = document.getElementById("signup-email-field");
const passwordField = document.getElementById("signup-password-field");
const nameInfoLabel = document.getElementById("name-field-info");
const emailInfoLabel = document.getElementById("email-field-info");
const passwordInfoLabel = document.getElementById("password-field-info");

const getColor = (status) => {
    return status == "success" ? "#43d439" : "#e96767";
};

const invalidateInfo = (target, status, msg) => {
    target.innerText = msg;
    target.style.color = getColor(status);
    target.style.visibility = "visible";
};

const invalidateField = (target, status) => {
    if (status == "success") {
        target.classList.remove("invalid-field");
    } else {
        if (!target.classList.contains("invalid-field")) {
            target.classList.add("invalid-field");
        }
    }
};

const invalidateElement = (field, label, status, msg) => {
    invalidateInfo(label, status, msg);
    invalidateField(field, status);
}

nameField.addEventListener("blur", e => {
    Rails.ajax({
        url: "/join/checkData",
        type: "get",
        data: new URLSearchParams({type: "name", data: e.target.value}).toString(),
        success: res => {
            if (res.status == "error") {
                throw new Error(res.msg);
            }

            invalidateElement(e.target, nameInfoLabel, res.status, res.msg);
        },
        error: err => {
            throw new Error(err);
        }
    });
});

emailField.addEventListener("blur", e => {
    const pattern = /^[a-zA-Z\d]+\@[a-zA-Z\d]+\.[a-zA-Z]+/;
    if (!pattern.test(e.target.value)) {
        invalidateElement(e.target, emailInfoLabel, "failed", "Please enter correct formed email");
        return;
    }

    Rails.ajax({
        url: "/join/checkData",
        type: "get",
        data: new URLSearchParams({type: "email", data: e.target.value}).toString(),
        success: res => {
            if (res.status == "error") {
                throw new Error(res.msg);
            }

            invalidateElement(e.target, emailInfoLabel, res.status, res.msg);
        },
        error: err => {
            throw new Error(err);
        }
    });
});

passwordField.addEventListener("blur", e => {
    const status = e.target.value == "" ? "failed" : "success";
    
    if (status == "success") {
        passwordInfoLabel.style.visibility = "hidden";
    } else {
        invalidateInfo(passwordInfoLabel, status, "This field is required");
    }

    invalidateField(e.target, status);
});