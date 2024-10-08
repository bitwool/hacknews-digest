defmodule Backend.ArticlesTest do
  use Backend.DataCase

  alias Backend.Articles

  describe "articles" do
    alias Backend.Articles.Article

    import Backend.ArticlesFixtures

    @invalid_attrs %{type: nil, title: nil, comments: nil, digest: nil, query_date: nil}

    test "list_articles/0 returns all articles" do
      article = article_fixture()
      assert Articles.list_articles() == [article]
    end

    test "get_article!/1 returns the article with given id" do
      article = article_fixture()
      assert Articles.get_article!(article.id) == article
    end

    test "create_article/1 with valid data creates a article" do
      valid_attrs = %{type: "some type", title: "some title", comments: %{}, digest: "some digest", query_date: "some query_date"}

      assert {:ok, %Article{} = article} = Articles.create_article(valid_attrs)
      assert article.type == "some type"
      assert article.title == "some title"
      assert article.comments == %{}
      assert article.digest == "some digest"
      assert article.query_date == "some query_date"
    end

    test "create_article/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Articles.create_article(@invalid_attrs)
    end

    test "update_article/2 with valid data updates the article" do
      article = article_fixture()
      update_attrs = %{type: "some updated type", title: "some updated title", comments: %{}, digest: "some updated digest", query_date: "some updated query_date"}

      assert {:ok, %Article{} = article} = Articles.update_article(article, update_attrs)
      assert article.type == "some updated type"
      assert article.title == "some updated title"
      assert article.comments == %{}
      assert article.digest == "some updated digest"
      assert article.query_date == "some updated query_date"
    end

    test "update_article/2 with invalid data returns error changeset" do
      article = article_fixture()
      assert {:error, %Ecto.Changeset{}} = Articles.update_article(article, @invalid_attrs)
      assert article == Articles.get_article!(article.id)
    end

    test "delete_article/1 deletes the article" do
      article = article_fixture()
      assert {:ok, %Article{}} = Articles.delete_article(article)
      assert_raise Ecto.NoResultsError, fn -> Articles.get_article!(article.id) end
    end

    test "change_article/1 returns a article changeset" do
      article = article_fixture()
      assert %Ecto.Changeset{} = Articles.change_article(article)
    end
  end
end
