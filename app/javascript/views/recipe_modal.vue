<script>
  export default {
    props: {
      recipe: {
        type: Object,
        required: true
      }
    },
    mounted() {
			const element = this.$refs.myModal
			this.modal = new bootstrap.Modal(element)
			this.modal.show()
			element.addEventListener('hidden.bs.modal', event => {
				this.$emit('hide')
			})
		},
  }
</script>
<template>
    <div ref="myModal" class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h1 class="modal-title fs-5" id="staticBackdropLabel">{{recipe.name}}</h1>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            ...
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            <button type="button" class="btn btn-primary">Understood</button>
          </div>
        </div>
      </div>
    </div>
</template>
