<template>
  <div class="list">
    <div class="title" :style="titleClasses">
      <i
        v-if="backAction"
        class="back-button fa fa-long-arrow-left"
        @click="backAction"
      ></i>
      {{title}}
    </div>
    <div class="elements">
        <div
          v-for='(elem, key) in list'
          class="element"
          :key="elem[keyDisplay]"
          @click="onItemSelect(elem)"
          >
            <div class="elem-pic" :style="elem.styles || titleClasses">
              {{ elem.letter || elem[keyDisplay][0] }}
            </div>
            <div v-if="elem.puce !== undefined && elem.puce !== 0" class="elem-puce">{{ elem.puce }}</div>
            <div class="elem-title">{{ elem[keyDisplay] }}</div>
        </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'gc-list',

    props: {
      title: { type: String, default: 'Title' },
      list: { type: Array, required: true },
      color: { type: String, default: '#FFFFFF' },
      backgroundColor: { type: String, default: '#4CAF50' },
      keyDisplay: { type: String, default: 'display' },
      disable: { type: Boolean, default: false },
      backAction: { type: Function, default: null }
    },

    computed: {
      titleClasses () {
        return {
          color: this.color,
          backgroundColor: this.backgroundColor
        }
      }
    },

    methods: {
      onItemSelect (element) {
        this.$emit('select', element)
      }
    }
  }
</script>

<style scoped>
  .list{
    height: 100%;
  }
  .title{
      padding-left: 12px;
      height: 34px;
      line-height: 34px;
      font-weight: 700;
  }

  .back-button {
    cursor: pointer;
  }

  .elements{
    height: calc(100% - 34px);
    overflow-y: auto;
  }
  .element{
      height: 40px;
      line-height: 40px;
      display: flex;
      align-items: center;
      position: relative;
  }

  .element:hover{
     background-color: #DDD;
  }

  .elem-pic{
      margin-left: 6px;
      height: 32px;
      width: 32px;
      text-align: center;
      line-height: 32px;
      font-weight: 700;
      border-radius: 50%;
  }
  .elem-puce{
    background-color: red;
    color:white;
    height: 12px;
    width: 12px;
    line-height: 12px;
    border-radius: 50%;
    text-align: center;
    font-size: 8px;
    margin: 0px;
    padding: 0px;
    position: absolute;
    left: 27px;
    top: 23px;
    z-index: 6;
  }
  .elem-title{
    margin-left: 6px;
  }
</style>
