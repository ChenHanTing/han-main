"use strict";

const axios = require("axios");

axios.defaults.headers.common = {
  "X-Requested-With": "XMLHttpRequest",
  "X-CSRF-TOKEN": document.getElementsByTagName("meta")["csrf-token"].content
};

const instance = axios.create({
  timeout: 1000,
  headers: {
    Accept: "application/json",
    "Content-Type": "multipart/form-data"
  }
});

export default instance;
