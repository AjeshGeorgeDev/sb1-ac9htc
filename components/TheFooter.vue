<template>
  <footer class="bg-white mt-auto">
    <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 py-12">
      <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
        <div>
          <h3 class="text-sm font-semibold text-gray-900">About Us</h3>
          <ul class="mt-4 space-y-4">
            <li>
              <NuxtLink to="/about" class="text-gray-600 hover:text-gray-900">
                Our Story
              </NuxtLink>
            </li>
          </ul>
        </div>
        <div>
          <h3 class="text-sm font-semibold text-gray-900">Customer Service</h3>
          <ul class="mt-4 space-y-4">
            <li>
              <NuxtLink to="/contact" class="text-gray-600 hover:text-gray-900">
                Contact Us
              </NuxtLink>
            </li>
          </ul>
        </div>
      </div>
      <div class="mt-8 border-t border-gray-200 pt-8">
        <p class="text-gray-400 text-sm text-center">
          © {{ new Date().getFullYear() }} Store. All rights reserved.
        </p>
      </div>
    </div>
  </footer>
</template>