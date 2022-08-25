# Generated by Django 4.0.6 on 2022-08-25 02:38

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0014_submission_name'),
    ]

    operations = [
        migrations.AlterField(
            model_name='submission',
            name='reviewers',
            field=models.ManyToManyField(blank=True, related_name='review_papers', to=settings.AUTH_USER_MODEL),
        ),
        migrations.CreateModel(
            name='VenueSchedule',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('activity', models.CharField(max_length=256)),
                ('start', models.DateTimeField(blank=True, null=True)),
                ('end', models.DateTimeField()),
                ('venue', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='schedule', to='api.venue')),
            ],
        ),
    ]
