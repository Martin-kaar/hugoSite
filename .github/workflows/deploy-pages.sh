name: Deploy Hugo

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Install hugo and build
        run: |
            sudo apt install hugo
            cd homepage
            hugo
      - name: Deploy to external repository
        uses: cpina/github-action-push-to-another-repository@main
        env:
          API_TOKEN_GITHUB: ${{ secrets.EXTERNAL_REPOSITORY_PERSONAL_ACCESS_TOKEN }}

        with:
          # GitHub Action output files
          source-directory: quickstart/public
          destination-github-username: martin-kaar
          destination-repository-name: martin-kaar.github.io
          user-email: marty.kaar@gmail.com
          