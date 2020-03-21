<template>
  <div>
    <h3>Add Item</h3>
    <p>現在還不知道怎麼使用ajax改變vue的狀態</p>
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
        <form
          class="new_items_import"
          id="new_items_import"
          enctype="multipart/form-data"
          action="/assignment/items_imports"
          accept-charset="UTF-8"
          data-remote="true"
          method="post"
        >
          <input name="utf8" type="hidden" value="✓" />
          <input type="file" name="items_import[file]" id="items_import_file" />
          <input
            type="submit"
            name="commit"
            value="Import File"
            data-disable-with="Import File"
          />
        </form>
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
        v-on:click="submitResult"
      />
      {{ result }}
    </div>
  </div>
</template>

<script>
export default {
  data: function() {
    return {
      newData: new String(),
      result: new Array(),
      hanItems: new Array(),
      chkAll: false
    };
  },
  methods: {
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
