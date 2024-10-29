<template>
  <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 py-12">
    <h1 class="text-3xl font-bold tracking-tight text-gray-900 mb-8">Shopping Cart</h1>

    <div v-if="items.length > 0" class="grid grid-cols-1 gap-x-8 gap-y-10 lg:grid-cols-12">
      <div class="lg:col-span-8">
        <ul role="list" class="divide-y divide-gray-200">
          <li v-for="item in items" :key="item.id" class="flex py-6">
            <div class="h-24 w-24 flex-shrink-0 overflow-hidden rounded-md border border-gray-200">
              <img :src="item.image_url" :alt="item.name" class="h-full w-full object-cover object-center">
            </div>

            <div class="ml-4 flex flex-1 flex-col">
              <div>
                <div class="flex justify-between text-base font-medium text-gray-900">
                  <h3>{{ item.name }}</h3>
                  <p class="ml-4">${{ (item.price * item.quantity).toFixed(2) }}</p>
                </div>
              </div>
              <div class="flex flex-1 items-end justify-between text-sm">
                <div class="flex items-center">
                  <label for="quantity" class="mr-2">Qty</label>
                  <input
                    type="number"
                    :value="item.quantity"
                    @input="updateQuantity(item.id, +$event.target.value)"
                    min="1"
                    class="w-16 rounded-md border-gray-300"
                  >
                </div>
                <button
                  @click="removeItem(item.id)"
                  class="font-medium text-indigo-600 hover:text-indigo-500"
                >
                  Remove
                </button>
              </div>
            </div>
          </li>
        </ul>
      </div>

      <div class="lg:col-span-4">
        <div class="rounded-lg bg-gray-50 p-6">
          <h2 class="text-lg font-medium text-gray-900">Order summary</h2>
          <div class="mt-6 space-y-4">
            <div class="flex items-center justify-between">
              <p class="text-sm text-gray-600">Subtotal</p>
              <p class="text-sm font-medium text-gray-900">${{ totalAmount.toFixed(2) }}</p>
            </div>
            <div class="border-t border-gray-200 pt-4">
              <button
                @click="navigateToCheckout"
                class="w-full rounded-md border border-transparent bg-indigo-600 px-4 py-3 text-base font-medium text-white shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2"
              >
                Proceed to Checkout
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div v-else class="text-center py-12">
      <p class="text-lg text-gray-600">Your cart is empty</p>
      <NuxtLink
        to="/products"
        class="mt-6 inline-flex items-center rounded-md border border-transparent bg-indigo-600 px-4 py-2 text-sm font-medium text-white shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2"
      >
        Continue Shopping
      </NuxtLink>
    </div>
  </div>
</template>

<script setup lang="ts">
const router = useRouter()
const { items, totalAmount, removeItem, updateQuantity } = useCart()

const navigateToCheckout = () => {
  router.push('/checkout')
}
</script>