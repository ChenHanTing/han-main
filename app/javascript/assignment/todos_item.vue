<template>
  <div>
    <h3>Add Item</h3>
    <div class="row">
      <div class="col-md-4 col-sm-4">
        <div class="form-group">
          <input type="text" class="form-control" id="content" />
        </div>
      </div>

      <div class="col-md col-sm">
        <div class="form-group">
          <button
            type="button"
            class="btn btn-primary"
            id="minimum_discount_add_btn"
            @click="addItem"
          >
            加入
          </button>
        </div>
      </div>
    </div>

    <div class="row">
      <div class="col-md-10 col-sm-10">
        <input
          type="file"
          name="items_import[file]"
          id="items_import_file_vue"
          data-target="file-uploader"
          accept=".xlsx, .xls, .csv"
          @change="fileUploader"
        />
        <input
          type="submit"
          name="commit"
          value="匯入"
          class="btn btn-info"
          data-disable-with="Import File"
          @click.prevent="importFile"
        />
        <a
          class="btn btn-dark"
          rel="nofollow"
          data-method="get"
          href="/assignment/items_imports/excel_template.xlsx"
          id="example_minimum_discount_file"
          ref="example_minimum_discount_file"
        >
          匯入範本下載
        </a>
      </div>
    </div>

    <br />

    <div class="row">
      <div class="col-md-10 col-sm-10">
        <table class="table table-hover table-striped table-sm">
          <thead class="thead" id="addTable">
            <tr>
              <th>
                <input type="checkbox" v-model="chkAll" @change="chkAllEvent" />
              </th>
              <th>內容</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(item, index) in hanItems">
              <td>
                <input type="checkbox" v-model="item.isChecked" />
              </td>
              <td>{{ item.content }}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <div class="row">
      <div class="col-md-2 col-sm-2">
        <div class="form-group">
          <button type="button" class="btn btn-dark" @click="removeItem">
            勾選移除
          </button>
        </div>
      </div>
    </div>

    <div class="form-group col-xs-12">
      <input
        type="button"
        value="提交"
        class="btn btn-primary"
        @click="submitResult"
      />
      {{ result }}
    </div>
  </div>
</template>

<script>
import axios from "../packs/axios_utils";

export default {
  data: function() {
    return {
      file: new String(),
      newData: new String(),
      result: new Array(),
      hanItems: new Array(),
      chkAll: false
    };
  },
  methods: {
    fileUploader(e) {
      // 判斷拖拉上傳或點擊上傳的 event
      const files = e.target.files || e.dataTransfer.files;

      // 預防檔案為空檔
      if (!files.length) {
        this.dragging = false;
        return;
      }

      this.createFile(this.hanItems, files[0]);
    },
    createFile(mainItems, file) {
      // 附檔名判斷
      console.log(file.type);
      if (
        !file.type.match(
          "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        )
      ) {
        console.log("不符合上傳格式");
        this.dragging = false;
        return;
      }

      // 檔案大小判斷
      if (file.size > 5000000) {
        console.log("檔案不能超過 5 MB");
        this.dragging = false;
        return;
      }

      this.file = file;
      this.dragging = false;

      let formData = new FormData();
      formData.append("items_import[file]", this.file);

      // 踩雷：這邊要寫 arrow function，不然`this.hanItems`無法辨識
      // header 可以不用寫，在 axios_utils 已經定義好了
      // response有data, status...等資訊
      axios
        .post("/assignment/items_imports.json", formData, {
          headers: {
            "Content-Type": "multipart/form-data"
          }
        })
        .then(response => {
          // 先印東西即可

          console.log(response);
          console.log(response.data);

          // JSON.parse(response.data).forEach(item => {
          //   this.hanItems.push({
          //     content: item.content,
          //     isChecked: false
          //   });
          // });
        })
        .catch(function(error) {
          console.log(error);
        });
    },
    importFile() {
      const excelfile = document.querySelector("#items_import_file_vue");
      const excelContent = excelfile.files[0];

      if (
        !excelContent.type.match(
          "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        )
      ) {
        console.log("不符合上傳格式");
        return;
      }

      // 檔案大小判斷
      if (excelContent.size > 5000000) {
        console.log("檔案不能超過 5 MB");
        return;
      }

      let formData = new FormData();
      formData.append("items_import[file]", excelContent);

      axios
        .post("/assignment/items_imports.json", formData, {
          headers: {
            "Content-Type": "multipart/form-data"
          }
        })

        // 踩雷：這邊要寫 arrow function，不然`this.hanItems`無法辨識
        .then(response => {
          console.log(response.data);
          JSON.parse(response.data).forEach(item => {
            this.hanItems.push({
              content: item.content,
              isChecked: false
            });
          });
        })
        .catch(function(error) {
          console.log(error);
        });
    },
    addItem() {
      const content = document.getElementById("content").value;
      if (!content) {
        return;
      }
      this.hanItems.push({ content, isChecked: false });
    },

    removeItem() {
      this.hanItems = this.hanItems.filter(item => !item.isChecked);
    },

    chkAllEvent() {
      let isChecked = this.chkAll; // 全選或全不選
      this.hanItems.forEach(item => (item.isChecked = isChecked));
    },

    submitResult() {
      this.result = new Array();

      this.hanItems.forEach(element => {
        const { content } = element;

        if (!element.isChecked)
          this.result.push(JSON.stringify({ content: content }));
      });
    }
  }
};
</script>
