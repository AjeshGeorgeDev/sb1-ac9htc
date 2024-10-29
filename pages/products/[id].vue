<template>
  <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 py-12">
    <div v-if="product" class="grid grid-cols-1 gap-x-8 gap-y-10 lg:grid-cols-2">
      <div class="lg:col-span-1">
        <img :src="product.image_url" :alt="product.name" class="rounded-lg">
      </div>

      <div class="lg:col-span-1">
        <h1 class="text-3xl font-bold tracking-tight text-gray-900">{{ product.name }}</h1>
        <div class="mt-4">
          <h2 class="sr-only">Product information</h2>
          <p class="text-3xl tracking-tight text-gray-900">${{ product.price }}</p>
        </div>

        <div class="mt-6">
          <h3 class="sr-only">Description</h3>
          <p class="text-base text-gray-900">{{ product.description }}</p>
        </div>

        <div class="mt-10">
          <button
            @click="addToCart"
            class="flex w-full items-center justify-center rounded-md border border-transparent bg-indigo-600 px-8 py-3 text-base font-medium text-white hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2"
          >
            Add to Cart
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
const route = useRoute()
const client = useSupabaseClient()
const { addItem } = useCart()

const { data: product } = await useAsyncData(
  'product',
  async () => {
    const { data } = await client
      .from('products')
      .select('*')
      .eq('id', route.params.id)
      .single()
    return data
  }
)

const addToCart = () => {
  if (product.value) {
    addItem({
      id: product.value.id,
      name: product.value.name,
      price: product.value.price,
      image_url: product.value.image_url,
      quantity: 1
    })
  }
}
</script>