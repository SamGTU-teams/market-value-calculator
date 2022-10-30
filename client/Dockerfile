FROM node:18-slim
WORKDIR /app
ENV NODE_ENV=production \
    PORT=80

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

COPY public ./public

COPY --chown=nextjs:nodejs .next/standalone ./
COPY --chown=nextjs:nodejs .next/static ./.next/static

USER nextjs

EXPOSE ${SERVER_PORT}

CMD ["node", "server.js"]
