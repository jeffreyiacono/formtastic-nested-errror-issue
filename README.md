## Sample App for formtastic/issues/714

Sample app for the issue raised here: [https://github.com/justinfrench/formtastic/issues/714](https://github.com/justinfrench/formtastic/issues/714)

Rails (3.1.3) app running Mongoid on the backend

## No Problem Here

All worked properly after using Formtastic properly (that is to say, it was my fault, there was no issue, these are not the droids you are looking for).

I had to ensure the controller / view was hooked up properly:

In the controller ...

```ruby
class ConversationsController < ApplicationController
  respond_to :html

  def new
    @conversation = Conversation.new
    @message      = @conversation.messages.build
  end
  ...
end
```
... and in the view:

```
%h1 New Conversation
= semantic_form_for @conversation, url: conversations_path do |form|
  = form.inputs do
    = form.input :subject
    = form.semantic_fields_for :messages, @message do |message|
      = message.input :body, as: :text
  = form.buttons do
    = form.commit_button label: 'Create Conversation'
```

I previously was initializing the ```@conversation``` in the controller and then building the conversation's message in the view, like this:

```ruby
class ConversationsController < ApplicationController
  respond_to :html

  def new
    @conversation = Conversation.new
  end
  ...
end
```
... and in the view:

```
%h1 New Conversation
= semantic_form_for @conversation, url: conversations_path do |form|
  = form.inputs do
    = form.input :subject
    = form.semantic_fields_for :messages, @conversation.messages.build do |message|
      = message.input :body, as: :text
  = form.buttons do
    = form.commit_button label: 'Create Conversation'
```

Which resulted in the error not being displayed for the message when the body was missing.

## One Item to Note

The error message on the associated object seems to be getting set twice:

![Screen Shot Showing Dup Flash Alert Message](https://lh5.googleusercontent.com/-QF8aTQAGPjc/TwYrthLsTtI/AAAAAAAAAeM/ZcuEG7Q6h6w/s720/Screenshot%252520at%2525202012-01-05%25252017%25253A00%25253A19.png)

Notice the :messages => ["is invalid", "is invalid"] within the @messages hash.
