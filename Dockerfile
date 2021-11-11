FROM node:fermium as builder
WORKDIR /app
COPY . .
RUN npm i

FROM larsks/thttpd as runner
LABEL org.opencontainers.image.authors="sergio@fenoll.be"
WORKDIR /
COPY --from=builder /app/index.html /www/index.html
COPY --from=builder /app/node_modules/@triply/yasgui/build/yasgui.min.css /www/yasgui.min.css
COPY --from=builder /app/node_modules/@triply/yasgui/build/yasgui.min.js /www/yasgui.min.js
ENTRYPOINT ["/thttpd", "-D", "-l", "/dev/stderr"]
CMD ["-d", "/www"]
