import { User } from '@supabase/supabase-js'
import { defineStore } from 'pinia'

export const useAuthStore = defineStore('auth', {
  state: () => ({
    user: null as User | null,
    loading: false,
    error: null as string | null,
  }),

  actions: {
    async signUp(email: string, password: string) {
      const client = useSupabaseClient()
      this.loading = true
      this.error = null

      try {
        const { error } = await client.auth.signUp({
          email,
          password,
        })
        if (error) throw error
      } catch (err: any) {
        this.error = err.message
      } finally {
        this.loading = false
      }
    },

    async signIn(email: string, password: string) {
      const client = useSupabaseClient()
      this.loading = true
      this.error = null

      try {
        const { error } = await client.auth.signInWithPassword({
          email,
          password,
        })
        if (error) throw error
      } catch (err: any) {
        this.error = err.message
      } finally {
        this.loading = false
      }
    },

    async signOut() {
      const client = useSupabaseClient()
      this.loading = true
      this.error = null

      try {
        const { error } = await client.auth.signOut()
        if (error) throw error
      } catch (err: any) {
        this.error = err.message
      } finally {
        this.loading = false
      }
    },
  },
})

export const useAuth = () => {
  const store = useAuthStore()
  const user = useSupabaseUser()

  watch(user, (newUser) => {
    store.user = newUser
  }, { immediate: true })

  return {
    user,
    loading: computed(() => store.loading),
    error: computed(() => store.error),
    signUp: store.signUp,
    signIn: store.signIn,
    signOut: store.signOut,
  }
}