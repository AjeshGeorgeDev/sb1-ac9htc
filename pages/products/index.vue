<template>
  <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 py-12">
    <div class="flex justify-between items-center mb-8">
      <h1 class="text-3xl font-bold tracking-tight text-gray-900">Products</h1>
      <div class="flex gap-4">
        <select v-model="selectedCategory" class="rounded-md border-gray-300">
          <option value="">All Categories</option>
          <option v-for="category in categories" :key="category.id" :value="category.id">
            {{ category.name }}
          </option>
        </select>
      </div>
    </div>

    <div class="grid grid-cols-1 gap-x-6 gap-y-10 sm:grid-cols-2 lg:grid-cols-4 xl:gap-x-8">
      <div v-for="product in filteredProducts" :key="product.id" class="group relative">
        <div class="aspect-h-1 aspect-w-1 w-full overflow-hidden rounded-md bg-gray-200 lg:aspect-none group-hover:opacity-75 lg:h-80">
          <img :src="product.image_url" :alt="product.name" class="h-full w-full object-cover object-center lg:h-full lg:w-full">
        </div>
        <div class="mt-4 flex justify-between">
          <div>
            <h3 class="text-sm text-gray-700">
              <NuxtLink :to="'/products/' + product.id">
                <span aria-hidden="true" class="absolute inset-0"></span>
                {{ product.name }}
              </NuxtLink>
            </h3>
            <p class="mt-1 text-sm text-gray-500">{{ product.category_name }}</p>
          </div>
          <p class="text-sm font-medium text-gray-900">${{ product.price }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
const client = useSupabaseClient()
const selectedCategory = ref('')

const { data: products } = await useAsyncData('products',
  async () => {
    const { data } = await client
      .from('products')
      .select(`
        *,
        categories (
          name
        )
      `)
    return data || []
  }
)

const { data: categories } = await useAsyncData('categories',
  async () => {
    const { data } = await client
      .from('categories')
      .select('*')
    return data || []
  }
)

const filteredProducts = computed(() => {
  if (!selectedCategory.value) return products.value
  return products.value?.filter(p => p.category_id === selectedCategory.value)
})
</script>