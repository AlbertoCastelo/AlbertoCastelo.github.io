FROM jekyll/jekyll

COPY --chown=jekyll:jekyll Gemfile .
COPY --chown=jekyll:jekyll Gemfile.lock .

RUN gem install bundler:1.17.3 &&\
    bundle update --bundler &&\
    bundle install --quiet --clean

CMD ["jekyll", "serve"]