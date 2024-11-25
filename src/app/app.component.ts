import { Component } from '@angular/core';
import { HttpClientModule } from '@angular/common/http';
import { ApiSampleService } from './services/api-sample.service';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [HttpClientModule, CommonModule],
  template: `
    <h1>{{ title }}</h1>
    <div *ngFor="let item of data">
      <strong>{{ item.id }}:</strong> {{ item.title }}
    </div>
  `,
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  title = 'ng-api-app';
  data: any[] = [];

  constructor(private apiService: ApiSampleService) {
    this.apiService.getData().subscribe(
      (response) => {
        this.data = response;
      },
      (error) => {
        console.error('Error fetching data:', error);
      }
    );
  }
}
