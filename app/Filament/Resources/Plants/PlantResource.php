<?php

namespace App\Filament\Resources\Plants;

use App\Filament\Resources\Plants\Pages\CreatePlant;
use App\Filament\Resources\Plants\Pages\EditPlant;
use App\Filament\Resources\Plants\Pages\ListPlants;
use App\Filament\Resources\Plants\Schemas\PlantForm;
use App\Filament\Resources\Plants\Tables\PlantsTable;
use App\Models\Plant;
use BackedEnum;
use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteAction;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\EditAction;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\TextInput;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;

class PlantResource extends Resource
{
    protected static ?string $model = Plant::class;

    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedRectangleStack;

    protected static ?string $recordTitleAttribute = 'Plant';

    public static function form(Schema $schema): Schema
    {
        return $schema
            ->components([
                TextInput::make('name_ar')
                    ->label('الاسم العربي')
                    ->required()
                    ->maxLength(150),

                TextInput::make('name_en')
                    ->label('الاسم الإنجليزي')
                    ->maxLength(150),

                Select::make('category')
                    ->label('الفئة')
                    ->options([
                        'خضار' => 'خضار',
                        'أشجار مثمرة' => 'أشجار مثمرة',
                        'أعشاب' => 'أعشاب',
                        'زينة' => 'زينة',
                    ])
                    ->required(),

                TextInput::make('family')
                    ->label('الفصيلة النباتية')
                    ->maxLength(100),

                Textarea::make('description')
                    ->label('الوصف')
                    ->rows(4)
                    ->columnSpanFull(),

                TextInput::make('image_url')
                    ->label('رابط الصورة')
                    ->maxLength(500)
                    ->url(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('id')
                    ->label('#'),
                TextColumn::make('name_ar')
                    ->label('الاسم العربي')
                    ->searchable()
                    ->sortable(),
                TextColumn::make('name_en')
                    ->label('الاسم الإنجليزي')
                    ->searchable(),
                TextColumn::make('category')
                    ->label('الفئة')
                    ->badge()
                    ->color(fn(string $state): string => match ($state) {
                        'خضار' => 'success',
                        'أشجار مثمرة' => 'warning',
                        'أعشاب' => 'info',
                        'زينة' => 'danger',
                        default => 'gray',
                    }),
                TextColumn::make('created_at')
                    ->label('أضيفت')
                    ->dateTime('Y-m-d'),
            ])
            ->actions([
                EditAction::make(),
                DeleteAction::make(),
            ])
            ->bulkActions([
                BulkActionGroup::make([
                    DeleteBulkAction::make(),
                ]),
            ]);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => ListPlants::route('/'),
            'create' => CreatePlant::route('/create'),
            'edit' => EditPlant::route('/{record}/edit'),
        ];
    }
}
