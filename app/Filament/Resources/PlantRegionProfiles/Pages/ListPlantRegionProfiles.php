<?php

namespace App\Filament\Resources\PlantRegionProfiles\Pages;

use App\Filament\Resources\PlantRegionProfiles\PlantRegionProfileResource;
use Filament\Actions\CreateAction;
use Filament\Resources\Pages\ListRecords;

class ListPlantRegionProfiles extends ListRecords
{
    protected static string $resource = PlantRegionProfileResource::class;

    protected function getHeaderActions(): array
    {
        return [
            CreateAction::make(),
        ];
    }
}
