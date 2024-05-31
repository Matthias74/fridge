import { createWebHistory, createRouter } from 'vue-router'
import Recipes from '@/views/recipes.vue'

const router = createRouter({
  history: createWebHistory(),
  routes: [
  	{ path: '/', component: Recipes, name: "root_path" }
  ]
});

export default router;
