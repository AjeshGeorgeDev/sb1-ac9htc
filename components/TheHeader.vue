<template>
  <header class="bg-white shadow-sm">
    <nav class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8" aria-label="Top">
      <div class="flex h-16 items-center justify-between">
        <div class="flex items-center">
          <NuxtLink to="/" class="text-2xl font-bold text-gray-900">
            Store
          </NuxtLink>
        </div>
        <div class="flex items-center space-x-8">
          <NuxtLink to="/products" class="text-gray-600 hover:text-gray-900">
            Products
          </NuxtLink>
          <NuxtLink to="/categories" class="text-gray-600 hover:text-gray-900">
            Categories
          </NuxtLink>
          <CartButton />
          <UserMenu />
        </div>
      </div>
    </nav>
  </header>
</template>