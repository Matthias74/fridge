<script>
  import axios from "axios"
  import { createApp } from 'vue/dist/vue.esm-bundler';

  //Vues
  import RecipeModal from './recipe_modal.vue'

	export default {
    data() {
      return {
        recipes: [],
        ingredients: [],
        ingredient: null,
        recipe: null,
      }
    },
    methods: {
      addIngredient() {
        this.ingredients.push(this.ingredient)
        this.ingredient = null
        console.log(this.ingredients)
      },
      removeIngredient(ingredient) {
        this.ingredients = this.ingredients.filter(i => i !== ingredient)
      },
      findRecipes() {
        axios.get(`/api/recipes`, {
					params: { ingredients: this.ingredients }
				})
				.then(function (response) {
					this.recipes = response.data.recipes
				}.bind(this))
      },
      displayeRecipe(recipe){
        this.recipe = recipe
        this.openModal()
      },
      showModal(modalComponent, data) {
	      const element = document.createElement("div")
	      document.body.appendChild(element)
	      const view = createApp(modalComponent, {
	      	onHide: (e) => {
            element.remove()
            this.recipe = null
          },
	      	recipe: this.recipe
	      }).mount(element)
      },

			openModal() {
				this.showModal(RecipeModal, {})
			},
    },
  }
</script>

<template>
  <div class="container">
    <div class="row">
      <div class="col-6">
        <div class="d-flex justify-content-center">
          <form class="form-inline w-75">
            <div class="form-group mb-2">
              <input
                v-model="ingredient"
                type="text"
                class="form-control"
                placeholder="enter an ingredient you have on your fridge"
              >
            </div>
          </form>
          <div class="form-group mb-2 ms-2">
            <button
              @click="addIngredient()"
              :disabled="!ingredient"
              :class="{ 'disabled': !ingredient}"
              class="btn btn-primary"
            >
              Add ingredient
            </button>
          </div>
        </div>
        <div class="mt-5">
          <h4>Ingredients:</h4>
          <ul v-if="ingredients.length">
            <li
              v-for="ingredient in ingredients" :key="ingredient"
              class="mt-2"
            >
              {{ ingredient }}
              <span
                @click="removeIngredient(ingredient)"
                class="btn btn-danger btn-sm"
              >
                remove
              </span>
            </li>
          </ul>
          <p v-else>No ingredients added yet</p>
        </div>
      </div>
      <div class="col-6">
        <div class="text-end">
          <button
            @click="findRecipes()"
            :disabled="!ingredients.length"
            :class="{ 'disabled': !ingredients.length}"
            class="btn btn-success"
          >
            Find recipes
          </button>
        </div>

        <h4 class="text-center">Recipes:</h4>
        <ul v-if="recipes.length">
          <li
            v-for="recipe in recipes" :key="recipe.id"
            class="mt-2"
          >
            {{ recipe.name }}
            <span 
              @click="displayeRecipe(recipe)"
              class="btn btn-sm btn-primary">Display</span>
          </li>
        </ul>
        <p v-else>No recipes found</p>
      </div>
    </div>
  </div>
</template>
