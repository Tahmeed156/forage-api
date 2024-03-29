# Generated by Django 4.0.6 on 2022-08-14 07:40

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0008_keyword_paper_keywords'),
    ]

    operations = [
        migrations.AddField(
            model_name='venue',
            name='reviewers',
            field=models.ManyToManyField(related_name='venues', to=settings.AUTH_USER_MODEL),
        ),
        migrations.CreateModel(
            name='SubmissionComment',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('text', models.TextField()),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='Submission',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('status', models.CharField(blank=True, max_length=128)),
                ('submitted', models.DateTimeField(blank=True, null=True)),
                ('project', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='api.project')),
                ('venue', models.ForeignKey(null=True, on_delete=django.db.models.deletion.PROTECT, to='api.venue')),
            ],
        ),
    ]
