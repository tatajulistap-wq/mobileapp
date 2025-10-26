# Gunakan versi Node yang lebih baru (mendukung toReversed)
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy package.json dan package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy semua file project
COPY . .

# Expose port Metro bundler
EXPOSE 8081

# Jalankan Metro bundler
CMD ["npx", "react-native", "start"]
