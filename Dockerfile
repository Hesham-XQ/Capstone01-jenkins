FROM node:13.12.0-alpine

## Step 1:
# Create working directory. (add the source code of our application to the image. This creates a directory called app in our image, and adds our source code to that directory.
WORKDIR /newapp

# Step 1a: add `/app/node_modules/.bin` to $PATH
#ENV PATH /app/node_modules/.bin:$PATH

## Step 2:
# Install package dependencies.COPY here copies the content of our packge.json file.
COPY package.json ./
COPY package-lock.json ./

## Step 3: install all the dependencies we might have installed locally, in our image
RUN npm install -g npm@latest

#RUN npm install


## Step 4:
# copies all the files in your local directory to the /app directory created in our image
COPY . .

## Step 5:
# Expose port 80. This informs Docker that the container listens on the specified network ports at runtime. EXPOSE does not make the ports of the container accessible to the host.
EXPOSE 80

## Step 6:
# Run/ start app at container launch
CMD ["npm", "start"]