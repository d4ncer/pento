defmodule Pento.Repo.Migrations.CreateFaqs do
  use Ecto.Migration

  def change do
    create table(:faqs) do
      add :question, :string
      add :answer, :string
      add :vote_count, :integer
      add :author_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:faqs, [:author_id])
  end
end
