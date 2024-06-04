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
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h1 class="modal-title fs-5" id="staticBackdropLabel">{{recipe.name}}</h1>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <div class="d-flex justify-content-between">
              <span>
                <span class="fw-semibold">Budget:</span>
                {{ recipe.budget || '- '}}
              </span>
              <span>
                <span class="fw-semibold">Cook Time:</span>
                {{ recipe.cook_time || '-' }}
              </span>
              <span>
                <span class="fw-semibold">Difficulty:</span>
                {{ recipe.difficulty || '-' }}
              </span>
              <span>
                <span class="fw-semibold">People quantity:</span>
                {{ recipe.people_quantity || '-' }}
              </span>
              <span>
                <span class="fw-semibold">Preparation Time:</span>
                {{ recipe.prep_time || '-' }}
              </span>
            </div>
            <div class="mt-5">
              <h2 class="fs-5">Ingredients</h2>
              <ul>
                <li v-for="ingredient in recipe.ingredients">
                  <span v-if="ingredient.quantity">
                    {{ ingredient.quantity + " "}}
                  </span>
                  <span>{{ ingredient.name }}</span>
                </li>
              </ul>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>
</template>
