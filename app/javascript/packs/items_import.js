import Vue from "vue";
import App from "../assignment/todos_item.vue";

document.addEventListener("DOMContentLoaded", () => {
  const el = "#dataTable";

  const dataTable = new Vue({
    el,
    render: h => h(App)
  });
});
