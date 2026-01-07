import CredentialsProvider from "next-auth/providers/credentials";
import { prisma } from "@/lib/prisma";
import bcrypt from "bcryptjs";

export const authOptions = {
    providers: [
        CredentialsProvider({
            name: "Credentials",
            credentials: {
                username: { label: "Username", type: "text" },
                password: { label: "Password", type: "password" }
            },
            async authorize(credentials) {
                const { username, password } = credentials;

                try {
                    // Use singleton prisma instance
                    console.log(`[Auth] Attempting login for user: ${username}`);

                    const user = await prisma.user.findUnique({
                        where: { username }
                    });

                    if (!user) {
                        console.warn(`[Auth] User not found: ${username}`);
                        return null;
                    }

                    if (user && user.password) {
                        let isValid = false;

                        // Check if password is bcrypt hash
                        if (user.password.startsWith('$2')) {
                            isValid = await bcrypt.compare(password, user.password);
                        } else {
                            console.warn(`[Auth] User ${username} has plaintext password. Login blocked for security.`);
                            isValid = false;
                        }

                        if (isValid) {
                            console.log(`[Auth] Login successful for user: ${username}`);
                            return {
                                id: user.id.toString(),
                                name: user.name,
                                email: null,
                                role: user.role || 'admin'
                            };
                        } else {
                            console.warn(`[Auth] Invalid password for user: ${username}`);
                        }
                    }
                } catch (e) {
                    console.error("[Auth] Login error:", e);
                }

                return null;
            }
        })
    ],
    session: {
        strategy: "jwt",
    },
    callbacks: {
        async jwt({ token, user }) {
            if (user) {
                token.id = user.id;
                token.role = user.role;
            }
            return token;
        },
        async session({ session, token }) {
            if (session.user) {
                session.user.id = token.id;
                session.user.role = token.role;
            }
            return session;
        }
    },
    pages: {
        signIn: '/login',
    },
    // Ensure secret is present. Fallback to a hardcoded logic if env is missing (prevent crash)
    secret: process.env.NEXTAUTH_SECRET || "fallback-secret-for-production-please-change",
    debug: process.env.NODE_ENV === 'development', // Enable debug logs in dev
};
